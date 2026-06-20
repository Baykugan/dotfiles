#!/bin/bash

STATEFILE="/tmp/hypr-display-mode"
PROFILES=(mirror internal external extended)

# Read last state
if [[ -f "$STATEFILE" ]]; then
    state=$(cat "$STATEFILE")
else
    state=0
fi

# Cycle to next
state=$(((state + 1) % ${#PROFILES[@]}))
echo "$state" > "$STATEFILE"

# Apply profile
nwg-displays -a "${PROFILES[$state]}"
