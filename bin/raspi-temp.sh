#!/bin/bash
#
# Purpose: Display the ARM CPU and GPU  temperature of Raspberry Pi 2/3 
#
cpu=$(</sys/class/thermal/thermal_zone0/temp)
echo
echo "$(date +'%a %d %b %Y %H:%M:%S %Z') @ $(hostname)"
echo "-------------------------------------------"
echo " GPU $(vcgencmd measure_temp)"
echo " CPU temp=$((cpu/1000))'C"
echo
