# Building QYQ OS 0.0.1

QYQ OS 0.0.1 is currently built as an amd64 UEFI raw disk image.

## Automated build

Every change to the build files on `master` triggers the GitHub Actions workflow:

```text
.github/workflows/build-0.0.1.yml
```

The workflow:

1. Installs the Debian image-building tools.
2. Creates a GPT disk image.
3. Creates a 512 MiB EFI System Partition.
4. Creates an ext4 root partition.
5. Bootstraps Debian Trixie with `debootstrap`.
6. Installs Linux, systemd and GRUB.
7. Adds the QYQ OS identity.
8. Boots the image with QEMU + OVMF.
9. Verifies that QYQ OS reaches the serial login prompt.
10. Uploads the compressed image, checksum and boot log as an artifact.

## Local build

A Debian or Ubuntu x86-64 build host is recommended.

Install dependencies:

```bash
# Refresh the host package index.
sudo apt-get update

# Install the tools used to create the partitioned disk image,
# bootstrap Debian, and perform the UEFI QEMU boot test.
sudo apt-get install -y \
  debootstrap \
  parted \
  dosfstools \
  e2fsprogs \
  qemu-system-x86 \
  ovmf
```

Build:

```bash
# Build the QYQ OS raw disk image.
# Root privileges are needed for loop devices, mounts and chroot.
sudo ./build/build-image.sh
```

Test:

```bash
# Boot the image in QEMU with OVMF (UEFI).
# The script checks the serial boot log for the QYQ OS login prompt.
sudo ./build/test-qemu.sh
```

Output:

```text
out/qyq-os-0.0.1-amd64.raw
out/qemu-boot.log
```

## 0.0.1 development login

For the first development image only:

```text
username: qyq
password: qyq
```

This fixed credential exists only to make early VM testing simple. It must be removed before QYQ OS becomes a user-facing installer or production image.
