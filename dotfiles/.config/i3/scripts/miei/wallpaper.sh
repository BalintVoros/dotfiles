#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="/home/$USER/Wallpapers/"


# Get a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Command to change the wallpaper, for example using feh
feh --bg-scale "$WALLPAPER"


