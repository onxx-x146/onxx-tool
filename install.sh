#!/data/data/com.termux/files/usr/bin/bash

# Open GitHub
echo -e "\033[38;5;214m[$current_time]\033[0m \033[1;32m[INFO]:\033[0mInstagram Open..."
am start -a android.intent.action.VIEW -d "https://Instagram.com/_.l2l_" com.android.chrome >/dev/null 2>&1 || {
    echo -e "\033[38;5;214m[$current_time]\033[0m \033[1;33m[WARNING]:\033[0m Could not open ."
}

URL="https://github.com/onxx-x146/onxx-tool/raw/refs/heads/main/install.tar.gz"
ARCHIVE="install.tar.gz"

# Clear terminal
clear

# Banner
printf '\033[92m'
cat <<'BANNER'
 ██████  ███    ██ ██   ██
██    ██ ████   ██  ██ ██
██    ██ ██ ██  ██   ███
██    ██ ██  ██ ██  ██ ██
 ██████  ██   ████ ██   ██
 
    BY: ONXX 🫅🏻
    Follow: _.l2l_
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
INSTALL_FILE=$(find . -type f -name "install" -print -quit)

if [ -z "$INSTALL_FILE" ]; then
    echo "[-] install.sh not found!"
    exit 1
fi

# Permission
chmod +x "$INSTALL_FILE"

echo "[+] Permission granted"
echo "[+] Starting install..."
echo

# Run install.sh
cd "$(dirname "$INSTALL_FILE")"
./install
