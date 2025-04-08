#!/bin/bash

STATE_FILE="/tmp/nightlight_state"

if [ -f "$STATE_FILE" ] && grep -q "ON" "$STATE_FILE"; then
    redshift -x
    echo "OFF" > "$STATE_FILE"
    echo "🌙"
else
    redshift -P -O 4300
    echo "ON" > "$STATE_FILE"
    echo "☀️"
fi

