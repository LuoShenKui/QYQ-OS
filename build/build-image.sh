#!/usr/bin/env bash
# Build a bootable QYQ OS 0.0.2 raw disk image.
#
# This script intentionally uses standard Debian tooling:
# - debootstrap creates the Debian userspace.
# - parted creates a GPT disk with an EFI System Partition.
# - grub-install installs a removable UEFI bootloader.
# - systemd provides the init/service-manager layer.
#
# Run as root on a Debian/Ubuntu build host.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/config/baseline.env"

OUT_DIR="$ROOT_DIR/out"
WORK_DIR="$ROOT_DIR/.build"
IMAGE="$OUT_DIR/qyq-os-${QYQ_VERSION}-amd64.raw"
MOUNT_DIR="$WORK_DIR/rootfs"

mkdir -p "$OUT_DIR" "$WORK_DIR" "$MOUNT_DIR"

cleanup() {
  set +e

  # Unmount bind mounts first because they live below the root filesystem.
  for path in dev/pts dev proc sys run boot/efi ""; do
    target="$MOUNT_DIR"
    [[ -n "$path" ]] && target="$MOUNT_DIR/$path"
    mountpoint -q "$target" && umount -R "$target"
  done

  # Detach the loop device if one was created.
  [[ -n "${LOOP_DEV:-}" ]] && losetup "$LOOP_DEV" >/dev/null 2>&1 && losetup -d "$LOOP_DEV"
}
trap cleanup EXIT

echo "[1/9] Creating ${DISK_SIZE} disk image..."
rm -f "$IMAGE"
truncate -s "$DISK_SIZE" "$IMAGE"

echo "[2/9] Creating GPT partition table..."
parted -s "$IMAGE" mklabel gpt
parted -s "$IMAGE" mkpart ESP fat32 1MiB 513MiB
parted -s "$IMAGE" set 1 esp on
parted -s "$IMAGE" mkpart root ext4 513MiB 100%

LOOP_DEV="$(losetup --find --show --partscan "$IMAGE")"
ESP_DEV="${LOOP_DEV}p1"
ROOT_DEV="${LOOP_DEV}p2"

# Wait briefly for partition device nodes to appear.
udevadm settle

echo "[3/9] Formatting filesystems..."
mkfs.vfat -F 32 -n QYQEFI "$ESP_DEV"
mkfs.ext4 -F -L QYQROOT "$ROOT_DEV"

echo "[4/9] Bootstrapping Debian ${DEBIAN_SUITE}..."
mount "$ROOT_DEV" "$MOUNT_DIR"
mkdir -p "$MOUNT_DIR/boot/efi"
mount "$ESP_DEV" "$MOUNT_DIR/boot/efi"

debootstrap   --arch="$DEBIAN_ARCH"   --include=systemd-sysv,linux-image-amd64,grub-efi-amd64,grub-efi-amd64-bin,openssh-server,ca-certificates,curl,iproute2,iputils-ping,isc-dhcp-client,sudo   "$DEBIAN_SUITE"   "$MOUNT_DIR"   "$DEBIAN_MIRROR"

echo "[5/9] Configuring QYQ OS identity and base system..."
cat > "$MOUNT_DIR/etc/os-release" <<EOF
PRETTY_NAME="QYQ OS 0.0.2"
NAME="QYQ OS"
VERSION_ID="0.0.2"
VERSION="0.0.2"
VERSION_CODENAME="trixie"
ID=qyq
ID_LIKE=debian
HOME_URL="https://github.com/LuoShenKui/QYQ-OS"
SUPPORT_URL="https://github.com/LuoShenKui/QYQ-OS/issues"
BUG_REPORT_URL="https://github.com/LuoShenKui/QYQ-OS/issues"
EOF

# Console/login banner should identify the distribution as QYQ OS.
cat > "$MOUNT_DIR/etc/issue" <<'EOF'
QYQ OS 0.0.2 \n \l

EOF

cat > "$MOUNT_DIR/etc/issue.net" <<'EOF'
QYQ OS 0.0.2
EOF

cat > "$MOUNT_DIR/etc/motd" <<'EOF'
QYQ OS 0.0.2
QiYinQiao Operating System
七音桥 操作系统

Based on Debian GNU/Linux 13 (Trixie)
EOF

echo "$HOSTNAME" > "$MOUNT_DIR/etc/hostname"

cat > "$MOUNT_DIR/etc/hosts" <<EOF
127.0.0.1 localhost
127.0.1.1 $HOSTNAME
::1       localhost ip6-localhost ip6-loopback
EOF

# Keep Debian repositories as the 0.0.2 package source.
cat > "$MOUNT_DIR/etc/apt/sources.list" <<EOF
deb $DEBIAN_MIRROR $DEBIAN_SUITE main
deb $DEBIAN_MIRROR $DEBIAN_SUITE-updates main
deb https://security.debian.org/debian-security $DEBIAN_SUITE-security main
EOF

ROOT_UUID="$(blkid -s UUID -o value "$ROOT_DEV")"
ESP_UUID="$(blkid -s UUID -o value "$ESP_DEV")"

cat > "$MOUNT_DIR/etc/fstab" <<EOF
UUID=$ROOT_UUID /         ext4 defaults,noatime 0 1
UUID=$ESP_UUID  /boot/efi vfat umask=0077       0 1
EOF

# DHCP for the first Ethernet interface created by QEMU.
mkdir -p "$MOUNT_DIR/etc/systemd/network"
cat > "$MOUNT_DIR/etc/systemd/network/20-wired.network" <<'EOF'
[Match]
Name=en*

[Network]
DHCP=yes
EOF

echo "[6/9] Preparing chroot..."
for fs in dev dev/pts proc sys run; do
  mount --bind "/$fs" "$MOUNT_DIR/$fs"
done

# Use the build host resolver while packages and GRUB are configured.
cp -L /etc/resolv.conf "$MOUNT_DIR/etc/resolv.conf"

echo "[7/9] Installing bootloader and enabling core services..."
chroot "$MOUNT_DIR" /bin/bash -eux <<'CHROOT'
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y \
  systemd-resolved \
  kde-standard \
  sddm \
  plasma-workspace \
  kwin-wayland \
  network-manager \
  fonts-noto-cjk \
  spice-vdagent \
  qemu-guest-agent

# Keep systemd-resolved for DNS, but use NetworkManager for desktop networking.
systemctl disable systemd-networkd || true
systemctl enable systemd-resolved
systemctl enable NetworkManager
systemctl enable ssh
systemctl enable sddm
systemctl enable qemu-guest-agent || true

# 0.0.2 boots to the graphical desktop login.
systemctl set-default graphical.target

# Create a non-root development user.
# The 0.0.2 image is a development artifact, not a production installer.
useradd -m -s /bin/bash qyq
usermod -aG sudo qyq
echo 'qyq:qyq' | chpasswd

# Serial console makes automated QEMU boot validation possible.
systemctl enable serial-getty@ttyS0.service

# Make GRUB visible on the serial console.
cat >> /etc/default/grub <<'EOF'
GRUB_TIMEOUT=1
GRUB_CMDLINE_LINUX_DEFAULT="console=tty0 console=ttyS0,115200n8"
GRUB_TERMINAL="console serial"
GRUB_SERIAL_COMMAND="serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1"
EOF

update-initramfs -u -k all
update-grub

# Install fallback UEFI path EFI/BOOT/BOOTX64.EFI so QEMU does not need an NVRAM entry.
grub-install   --target=x86_64-efi   --efi-directory=/boot/efi   --bootloader-id=QYQ   --removable   --no-nvram

# Store build identity.
mkdir -p /usr/lib/qyq
cat > /usr/lib/qyq/release <<'EOF'
QYQ_VERSION=0.0.2
BASE=Debian 13 / trixie
ARCH=amd64
EOF
CHROOT

echo "[8/9] Cleaning image..."
chroot "$MOUNT_DIR" apt-get clean
rm -rf "$MOUNT_DIR/var/lib/apt/lists/"*
rm -f "$MOUNT_DIR/etc/resolv.conf"
ln -s ../run/systemd/resolve/stub-resolv.conf "$MOUNT_DIR/etc/resolv.conf"

sync

echo "[9/9] Build complete:"
ls -lh "$IMAGE"
echo
echo "Development login: qyq / qyq"
echo "Image: $IMAGE"
