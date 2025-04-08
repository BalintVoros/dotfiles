#!/bin/bash

CARD="alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic"
PROFILE_HEADPHONES="HiFi (HDMI1, HDMI2, HDMI3, Headphones, Mic1, Mic2)"
PROFILE_SPEAKERS="HiFi (HDMI1, HDMI2, HDMI3, Mic1, Mic2, Speaker)"

# Get current active profile directly from pactl
CURRENT_PROFILE=$(pactl list cards | awk -v card="$CARD" '
  $0 ~ "Card #" {in_card = 0}
  $0 ~ card {in_card = 1}
  in_card && /Active Profile:/ {
    print substr($0, index($0,$3))
    exit
  }
')

# Debug print (optional)
# echo "Current profile: $CURRENT_PROFILE"

if [[ "$CURRENT_PROFILE" == *"Speaker"* ]]; then
    pactl set-card-profile "$CARD" "$PROFILE_HEADPHONES"
    notify-send -i audio-headphones "Audio Output" "Switched to Headphones"
else
    pactl set-card-profile "$CARD" "$PROFILE_SPEAKERS"
    notify-send -i audio-speakers "Audio Output" "Switched to Speakers"
fi

