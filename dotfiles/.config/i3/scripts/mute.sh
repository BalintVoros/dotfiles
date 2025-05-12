#!/bin/bash

# Toggle microphone mute status
MIC_STATE=$(amixer get Capture | grep '\[on\]' | wc -l)

if [ "$MIC_STATE" -gt 0 ]; then # Check if mic state is greater than 0 (i.e., on)
    # Mute the microphone
    amixer set Capture nocap > /dev/null 2>&1
    notify-send "Microphone Muted" "Your microphone is now off." -i microphone-sensitivity-muted
    echo " Off"
else
    # Unmute the microphone
    amixer set Capture cap > /dev/null 2>&1
    notify-send "Microphone Unmuted" "Your microphone is now on." -i microphone-sensitivity-high
    echo " On"
fi