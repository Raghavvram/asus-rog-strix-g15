#!/bin/bash

# Get current profile
current_profile=$(powerprofilesctl get)

# Determine the next profile
case $current_profile in
  "performance")
    next_profile="balanced"
    ;;
  "balanced")
    next_profile="power-saver"
    ;;
  "power-saver")
    next_profile="performance"
    ;;
  *)
    next_profile="balanced"
    ;;
esac

# Set the next profile
powerprofilesctl set $next_profile
echo "Switched to $next_profile"
