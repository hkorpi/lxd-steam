#!/usr/bin/env bash

set -euo pipefail
cd $(dirname $0)

lxc launch ubuntu:24.04 --profile default --profile steam steam
lxc exec steam -- cloud-init status --wait

# Add missing nvidia runtime files from nvidia library packages
# nvidia runtime is not complete and there are some library and configuration files missing e.g.
# - /usr/share/vulkan/icd.d/nvidia_icd.json
# - /usr/share/glvnd/egl_vendor.d/10_nvidia.json
# Note: you have to use the same nvidia library version as in the host
lxc exec steam -- mkdir -p /tmp/nvidia
lxc file push ./nvidia-drivers.sh steam/tmp/nvidia/drivers.sh
lxc exec steam -- /tmp/nvidia/drivers.sh libnvidia-gl-550
lxc exec steam -- rm -rf /tmp/nvidia
lxc restart steam

lxc file push ./start-steam.sh steam/home/ubuntu/start-steam.sh
lxc file push ./fix-render-permission.sh steam/home/ubuntu/fix-render-permission.sh
lxc exec steam -- chown ubuntu:ubuntu /home/ubuntu

