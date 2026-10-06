#!/usr/bin/env bash
# Boot-test the QYQ OS desktop image in QEMU using UEFI and the serial console.
#
# Success criteria for 0.0.2:
# 1. UEFI loads GRUB and Linux boots.
# 2. systemd reaches graphical.target.
# 3. SDDM starts successfully.
# 4. QYQ OS 0.0.2 identity is visible on the serial console.
#
# This is an automated smoke test. The actual Plasma desktop must still be
# validated manually with a graphical QEMU window.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/config/baseline.env"

IMAGE="${1:-$ROOT_DIR/out/qyq-os-${QYQ_VERSION}-amd64.raw}"
LOG="$ROOT_DIR/out/qemu-boot.log"

OVMF_CODE=""
for candidate in \
  /usr/share/OVMF/OVMF_CODE.fd \
  /usr/share/OVMF/OVMF_CODE_4M.fd; do
  if [[ -f "$candidate" ]]; then
    OVMF_CODE="$candidate"
    break
  fi
done

if [[ -z "$OVMF_CODE" ]]; then
  echo "OVMF firmware not found." >&2
  exit 1
fi

rm -f "$LOG"

echo "Booting $IMAGE with $OVMF_CODE"

# Keep a virtual GPU present so the display manager has a DRM device, while
# routing the test output through the serial console for CI.
set +e
timeout 180s qemu-system-x86_64 \
  -machine q35,accel=tcg \
  -m 4096 \
  -smp 4 \
  -drive "if=pflash,format=raw,readonly=on,file=$OVMF_CODE" \
  -drive "file=$IMAGE,format=raw,if=virtio" \
  -netdev user,id=net0 \
  -device virtio-net-pci,netdev=net0 \
  -device virtio-vga \
  -display none \
  -serial stdio \
  -monitor none \
  >"$LOG" 2>&1
QEMU_RC=$?
set -e

cat "$LOG"

IDENTITY_OK=0
GRAPHICAL_OK=0
SDDM_OK=0

grep -q "QYQ OS 0.0.2" "$LOG" && IDENTITY_OK=1
grep -Eq "Reached target .*graphical.target|Reached target Graphical Interface" "$LOG" && GRAPHICAL_OK=1
grep -Eqi "Started .*sddm|Started sddm.service|Simple Desktop Display Manager" "$LOG" && SDDM_OK=1

if [[ "$IDENTITY_OK" -eq 1 && "$GRAPHICAL_OK" -eq 1 && "$SDDM_OK" -eq 1 ]]; then
  echo "QYQ OS 0.0.2 desktop boot verification PASSED."
  exit 0
fi

echo "QYQ OS 0.0.2 desktop boot verification FAILED (QEMU exit: $QEMU_RC)." >&2
echo "identity=$IDENTITY_OK graphical_target=$GRAPHICAL_OK sddm=$SDDM_OK" >&2
exit 1
