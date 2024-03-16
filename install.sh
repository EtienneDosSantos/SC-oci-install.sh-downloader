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
    cd stable-cascade-one-click-installer && git pull
fi

# Ensure we are in the stable-cascade-one-click-installer directory for Python environment setup
cd "$script_dir/stable-cascade-one-click-installer" || exit

# Set error flag
set -e

# Check for Python and exit if not found
if ! [ -x "$(command -v python)" ]; then
  echo 'Error: python is not installed.' >&2
  exit 1
fi

# Create a virtual environment
if [ ! -d "venv" ]; then
  python -m venv venv
fi

# Upgrade pip before `pip install`
./venv/bin/python -m pip install --upgrade pip

# Install other requirements
./venv/bin/pip install -r requirements.txt

# Move new_install.sh into the root of stable-cascade-one-click-installer directory
mv "$script_dir/install.sh" "$script_dir/stable-cascade-one-click-installer/"

echo "Installation completed. Execute \`run.sh\` script to start generating!"
