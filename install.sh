#!/data/data/com.termux/files/usr/bin/bash

URL="https://github.com/onxx-x146/onxx-tool/raw/refs/heads/main/install.tar.gz"
ARCHIVE="install.tar.gz"

# Clear terminal
clear

# Banner
printf '\033[91m'
cat <<'BANNER'
 ██████  ███    ██ ██   ██
██    ██ ████   ██  ██ ██
██    ██ ██ ██  ██   ███
██    ██ ██  ██ ██  ██ ██
 ██████  ██   ████ ██   ██
 
    BY: ONXX 🫅🏻 IG _insrnx_
BANNER
printf '\033[0m\n'

echo "[+] Downloading..."

# Download
if command -v curl >/dev/null 2>&1; then
    curl -L "$URL" -o "$ARCHIVE"
elif command -v wget >/dev/null 2>&1; then
    wget -O "$ARCHIVE" "$URL"
else
    echo "[-] curl/wget not found!"
    echo "[!] Install: pkg install curl -y"
    exit 1
fi

if [ ! -s "$ARCHIVE" ]; then
    echo "[-] Download failed!"
    exit 1
fi

echo "[+] Download complete"
echo "[+] Extracting..."

# Extract
if ! tar -xzf "$ARCHIVE"; then
    echo "[-] Extraction failed!"
    rm -f "$ARCHIVE"
    exit 1
fi

rm -f "$ARCHIVE"

# Find install.sh
INSTALL_FILE=$(find . -type f -name "install.sh" -print -quit)

if [ -z "$INSTALL_FILE" ]; then
    echo "[-] install.sh not found!"
    exit 1
fi

# Permission
chmod +x "$INSTALL_FILE"

echo "[+] Permission granted"
echo "[+] Starting install.sh..."
echo

# Run install.sh
cd "$(dirname "$INSTALL_FILE")"
./install.sh
