#!/usr/bin/env bash

# Keyboard Color Profile Cycler for ASUS laptops
# Cycles through different aura modes and colors

# Configuration file to store current profile index
CONFIG_FILE="$HOME/.config/keyboard-color-profile"

# Define the color profiles (mode:color combinations)
# Format: "mode:color_args:description"
PROFILES=(
    "static:ff0000:Red Static"
    "static:00ff00:Green Static"
    "static:0000ff:Blue Static"
    "static:ff00ff:Purple Static"
    "static:ffff00:Yellow Static"
    "static:00ffff:Cyan Static"
    "static:ffffff:White Static"
    "breathe:ff0000:Red Breathing"
    "breathe:0000ff:Blue Breathing"
    "rainbow-cycle::Rainbow Cycle"
    "rainbow-wave::Rainbow Wave"
    "pulse:ff0000:Red Pulse"
    "pulse:ffffff:White Pulse"
)

# Create config directory if it doesn't exist
mkdir -p "$(dirname "$CONFIG_FILE")"

# Read current profile index, default to 0 if file doesn't exist
if [[ -f "$CONFIG_FILE" ]]; then
    CURRENT_INDEX=$(cat "$CONFIG_FILE")
else
    CURRENT_INDEX=0
fi

# Calculate next profile index (cycle back to 0 if at end)
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#PROFILES[@]} ))

# Get the next profile
PROFILE=${PROFILES[$NEXT_INDEX]}
IFS=':' read -r MODE COLOR_ARGS DESCRIPTION <<< "$PROFILE"

# Apply the keyboard color profile
case "$MODE" in
    "static")
        asusctl aura static -c "$COLOR_ARGS"
        ;;
    "breathe")
        asusctl aura breathe -c "$COLOR_ARGS"
        ;;
    "rainbow-cycle")
        asusctl aura rainbow-cycle
        ;;
    "rainbow-wave")
        asusctl aura rainbow-wave
        ;;
    "pulse")
        asusctl aura pulse -c "$COLOR_ARGS"
        ;;
esac

# Save the new index
echo "$NEXT_INDEX" > "$CONFIG_FILE"

# Send notification (if notify-send is available)
if command -v notify-send >/dev/null 2>&1; then
    notify-send -a "Keyboard Profile" -t 2000 -i "input-keyboard" "Keyboard Profile" "$DESCRIPTION"
fi

echo "Switched to: $DESCRIPTION"
