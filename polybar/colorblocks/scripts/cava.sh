#!/bin/bash

# Characters for the bars
bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# Map numbers to bar characters
i=0
while [ $i -lt ${#bar} ]; do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i+1))
done

# Write temporary CAVA configuration
config_file="/tmp/polybar_cava_config"
echo "
[general]
framerate = 60
bars = 10

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7

[input]
method = pulse
source = auto
" > $config_file

# Check if audio is playing
audio_status=$(pactl list sink-inputs short | wc -l)

if [ "$audio_status" -gt 0 ]; then
    # If audio is playing, show the CAVA visualization
    cava -p $config_file | while read -r line; do
        echo "${COLOR}$(echo $line | sed "$dict")%{F-}"
    done
else
    # If no audio is playing, hide the visualization
    echo ""
fi
