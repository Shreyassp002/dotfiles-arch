#!/bin/bash

# Define Polybar-compatible color codes
CONNECTED_PREFIX="%{F#fcab6d}%{F-}"      # Prefix for connected (orange)
DISCONNECTED_PREFIX="%{F#ff3b65}%{F-}"   # Prefix for disconnected (red)
CONNECTED_COLOR="%{F#f5c4bf}"              # Foreground color for connected (light pink)
DISCONNECTED_COLOR="%{F#f8befa}"           # Foreground color for disconnected (light purple)
RESET="%{F-}"                              # Reset color

# Check for connected devices
connected_device=$(bluetoothctl devices | while read -r type mac name; do
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
        echo "$name"
        break
    fi
done)

if [ -z "$connected_device" ]; then
    echo " ${DISCONNECTED_PREFIX} ${DISCONNECTED_COLOR}Disconnected${RESET} "
else
    echo " ${CONNECTED_PREFIX} ${CONNECTED_COLOR}${connected_device}${RESET} "
fi
