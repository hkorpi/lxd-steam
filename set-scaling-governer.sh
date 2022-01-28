#!/usr/bin/env bash

for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
do
 echo $1 > $f
 echo "Set $f: $1"
done
