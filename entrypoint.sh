#!/bin/bash
set -e

# Set required environment variables
export USER=root

# Wait for network connectivity
until ping -c 1 google.com >/dev/null 2>&1; do
    echo "Waiting for network connectivity..."
    sleep 0.5
done

# Source uv environment and update shell
source /usr/local/bin/uv/env
SHELL=/bin/bash uv tool update-shell

# Add uv tool bin directory to PATH
export PATH="/root/.local/bin:$PATH"

# Install quicklizard if not already installed
if ! command -v quicklizard >/dev/null 2>&1; then
    echo "Installing quicklizard..."
    uv tool install git+https://github.com/gkwa/quicklizard
fi

# Run quicklizard with the correct PATH
exec /root/.local/bin/quicklizard -vvv
