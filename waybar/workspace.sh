#!/bin/bash

# fetch workspace info from hyprctl
workspaces=$(hyprctl workspaces -j | jq -r '.[] | "\(.id):\(.name) \(.windows > 0 and "*" or "")"')

# output formatted workspaces
echo "$workspaces" | tr '\n' ' '

