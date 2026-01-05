#!/usr/bin/env bash

set -euo pipefail

chmod 666 /dev/dri/renderD128
chown root:render /dev/dri/renderD128
