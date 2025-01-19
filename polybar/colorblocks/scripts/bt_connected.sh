#!/bin/bash

# Define Polybar-compatible color codes
CONNECTED_PREFIX="%{F#fcab6d}%{F-}"      # Prefix for connected (orange)
DISCONNECTED_PREFIX="%{F#ff3b65}%{F-}"   # Prefix for disconnected (red)
CONNECTED_COLOR="%{F#f5c4bf}"              # Foreground color for connected (light pink)
DISCONNECTED_COLOR="%{F#f8befa}"           # Foreground color for disconnected (light purple)
RESET="%{F-}"                              # Reset color

# Get the list of connected devices
connected_device=$(bluetoothctl devices Connected | awk '{$1=$2=""; print $0}' | sed 's/^ *//')

if [ -z "$connected_device" ]; then
    # Disconnected case: Use red prefix and purple foreground
    echo " ${DISCONNECTED_PREFIX} ${DISCONNECTED_COLOR}Disconnected${RESET} "
else
    # Connected case: Use orange prefix and light pink foreground
    echo " ${CONNECTED_PREFIX} ${CONNECTED_COLOR}$connected_device${RESET} "
fi
