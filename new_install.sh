#!/bin/bash

# Get the script's directory
script_dir="$(dirname "$(readlink -f "$0")")"

# Change the directory and execute git commands
cd "$script_dir" || exit
if [ ! -d "stable-cascade-one-click-installer" ]; then
    echo "Project not found. Initializing download..."
    git clone https://github.com/EtienneDosSantos/stable-cascade-one-click-installer
else
    echo "Updating project..."
    git pull
fi

echo "Done!"
