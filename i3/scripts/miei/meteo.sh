#!/usr/bin/bash

meteo_url="https://wttr.in/Nagyvázsony?format=1"

meteo=$(curl "$meteo_url" | xargs echo)
first="${meteo%% *}"

if [ "$meteo" == "" ] || [ "$first" == "Unknown" ]; then
	echo "  Off"
else
	echo $meteo
fi

# Function to open the link on right-click
handle_click() {
	button="$1"
	if [ "$button" == "3" ]; then # Right-click is button 3
		xdg-open "https://wttr.in/Nagyvázsony"
	fi
}

# Listen for mouse events (if integrated with a status bar like i3blocks)
if [ ! -z "$BLOCK_BUTTON" ]; then
	handle_click "$BLOCK_BUTTON"
fi
