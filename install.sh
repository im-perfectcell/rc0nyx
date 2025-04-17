#!/bin/bash
# install.sh - Installs rec0nyx system-wide for direct use as "rec0nyx"

set -e

SCRIPT_NAME="rec0nyx"
DEST="/usr/local/bin/$SCRIPT_NAME"

if [[ ! -f "$SCRIPT_NAME" ]]; then
    echo "[!] $SCRIPT_NAME not found in the current directory."
    exit 1
fi

echo "[*] Copying $SCRIPT_NAME to $DEST ..."
sudo cp "$SCRIPT_NAME" "$DEST"
sudo chmod +x "$DEST"

if command -v rec0nyx >/dev/null 2>&1; then
    echo "[+] rec0nyx is now installed! You can run it from anywhere:"
    echo "    rec0nyx <target.com> [options]"
else
    echo "[!] Installation failed. Please check /usr/local/bin is in your \$PATH."
fi