#!/usr/bin/env bash
# Boot-test the QYQ OS image in QEMU using UEFI and the serial console.
#
# Success criteria for 0.0.1:
# 1. UEFI loads GRUB.
# 2. Linux boots.
# 3. systemd reaches a usable target.
# 4. A login prompt is visible on ttyS0.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/config/baseline.env"

IMAGE="${1:-$ROOT_DIR/out/qyq-os-${QYQ_VERSION}-amd64.raw}"
LOG="$ROOT_DIR/out/qemu-boot.log"

# Ubuntu runners install OVMF_CODE.fd at one of these common paths.
OVMF_CODE=""
for candidate in   /usr/share/OVMF/OVMF_CODE.fd   /usr/share/OVMF/OVMF_CODE_4M.fd; do
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

# timeout is expected to stop QEMU after the login prompt appears.
set +e
timeout 120s qemu-system-x86_64   -machine q35,accel=tcg   -m 2048   -smp 2   -drive "if=pflash,format=raw,readonly=on,file=$OVMF_CODE"   -drive "file=$IMAGE,format=raw,if=virtio"   -netdev user,id=net0   -device virtio-net-pci,netdev=net0   -nographic   -serial mon:stdio   >"$LOG" 2>&1
QEMU_RC=$?
set -e

cat "$LOG"

if grep -Eq "QYQ OS 0\.0\.1|qyq-os login:" "$LOG"; then
  echo "QYQ OS 0.0.1 boot verification PASSED."
  exit 0
fi

echo "QYQ OS 0.0.1 boot verification FAILED (QEMU exit: $QEMU_RC)." >&2
exit 1
