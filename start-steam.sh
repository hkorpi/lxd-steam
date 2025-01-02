#!/usr/bin/env bash

set -euo pipefail
cd $(dirname $0)

sudo ./fix-render-permission.sh
systemctl --user import-environment DISPLAY
PULSE_SERVER=unix:/home/ubuntu/pulse-native __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia steam
