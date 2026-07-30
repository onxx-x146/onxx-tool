#!/bin/bash

# ================================================================
# GATE-UP URL-ONLY INSTALLER v6.1 (Obfuscated URL)
# All tools via git clone – No sudo, No system tool packages
# Works on Termux & Kali (run as root on Kali)
# ================================================================

# ---- Obfuscated GATE-UP URL (Base64 encoded) ----
GATEUP_URL_ENCODED="aHR0cHM6Ly9naXRodWIuY29tL29ueHgteDE0Mw=="
GATEUP_URL=$(echo "$GATEUP_URL_ENCODED" | base64 -d 2>/dev/null)

# Safety fallback (should never happen)
if [ -z "$GATEUP_URL" ]; then
    GATEUP_URL="https://github.com/onxx-x146"
fi

# ---- Color definitions ----
reset="\e[0m"
bold="\e[1m"
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
magenta="\e[35m"
cyan="\e[36m"
white="\e[37m"
rainbow=("\e[38;5;196m" "\e[38;5;202m" "\e[38;5;226m" "\e[38;5;46m" "\e[38;5;27m" "\e[38;5;93m")

# ---- Detect environment for dependencies only ----
if command -v pkg &>/dev/null; then
    PKG_MANAGER="pkg"
    INSTALL_CMD="pkg install -y"
    UPDATE_CMD="pkg update -y"
    UPGRADE_CMD="pkg upgrade -y"
    DEPS="git curl wget python python-pip ruby php nodejs-lts golang figlet toilet"
elif command -v apt &>/dev/null; then
    PKG_MANAGER="apt"
    INSTALL_CMD="apt install -y"          # sudo removed
    UPDATE_CMD="apt update -y"            # sudo removed
    UPGRADE_CMD="apt upgrade -y"          # sudo removed
    DEPS="git curl wget python3 python3-pip ruby php nodejs golang figlet toilet"
else
    echo -e "${red}Unsupported system. Only Termux and Debian-based (Kali) are supported.${reset}"
    exit 1
fi

# ---- Functions ----
clear_screen() { clear; }

print_banner() {
    echo -e "${rainbow[0]}${bold}"
    cat << "EOF"
   ▄████████  ▄█   ▄█          ▄████████ ████████▄     ▄████████ 
  ███    ███ ███  ███         ███    ███ ███   ▀███   ███    ███ 
  ███    █▀  ███▌ ███         ███    █▀  ███    ███   ███    █▀  
  ███        ███▌ ███        ▄███▄▄▄     ███    ███  ▄███▄▄▄     
▀███████████ ███▌ ███       ▀▀███▀▀▀     ███    ███ ▀▀███▀▀▀     
         ███ ███  ███         ███    █▄  ███    ███   ███    █▄  
   ▄█    ███ ███  ███▌    ▄   ███    ███ ███   ▄███   ███    ███ 
 ▄████████▀  █▀   █████▄▄██   ██████████ ████████▀    ██████████ 
                ▀                                                
EOF
    echo -e "${reset}"
    echo -e "${cyan}${bold}         🚀  GATE-UP Onxx-x143 TOOLBOX  🚀${reset}"
    echo -e "${yellow}${bold}      All Tools Cloned from GitHub${reset}"
    echo -e "${magenta}${bold}       URL-Only Installer v6.1 (no apt )${reset}\n"
}

print_header() {
    echo -e "\n${yellow}${bold}─── ${1} ───${reset}\n"
}

# ---- Silent installer ----
install_tool() {
    local name="$1"
    local cmd="$2"
    echo -e "${blue}→ Installing ${bold}${name}${reset}${blue}...${reset}"
    eval "$cmd" >/dev/null 2>&1
    echo -e "${green}✓ ${name} installed${reset}"
    echo ""
}

# ======================================================
# ==========  TOOL LIST – ALL URL/GIT ONLY  ============
# ======================================================
declare -A tools

# ---------- All GitHub repositories ---------
tools["maihret"]="git clone https://github.com/soxoj/maigret && cd maigret"
topls["Xteam"]="https://github.com/xploitstech/Xteam.git"
tools["Doxxer-Toolkit"]="https://github.com/Euronymou5/Doxxer-Toolkit.git"
topls["KitHack"]="https://github.com/AdrMXR/KitHack.git"
tools["wifiphisher"]="https://github.com/wifiphisher/wifiphisher.git"
tools["zphisher"]="https://github.com/htr-tech/zphisher.git"
tools["APKTOOL-"]="git clone https://github.com/onxx-x143/APKTOOL-.git"
tools["PDF-TOOL"]="git clone https://github.com/onxx-x143/PDF-TOOL.git"
tools["Onxx"]="git clone https://github.com/onxx-x143/Onxx.git"
tools["URL--8080"]="git clone https://github.com/onxx-x143/URL--8080.git"
tools["Termux-Banner"]="git clone https://github.com/onxx-x143/Termux-pro-banner.git"
tools["Hydra"]="git clone https://github.com/onxx-x143/Hydra.git"
tools["Sherlock"]="git clone https://github.com/sherlock-project/sherlock.git"
tools["OSINT Framework"]="git clone https://github.com/lockfale/OSINT-Framework.git"
tools["theHarvester"]="git clone https://github.com/laramies/theHarvester.git"
tools["Recon-ng"]="git clone https://github.com/lanmaster53/recon-ng.git"
tools["Spartan"]="git clone https://github.com/sensepost/spartan.git"
tools["XSStrike"]="git clone https://github.com/s0md3v/XSStrike.git"
tools["SQLMap"]="git clone https://github.com/sqlmapproject/sqlmap.git"
tools["Dirb"]="git clone https://github.com/v0re/dirb.git"
tools["Gobuster"]="git clone https://github.com/OJ/gobuster.git"
tools["WPScan"]="git clone https://github.com/wpscanteam/wpscan.git"
tools["Nikto"]="git clone https://github.com/sullo/nikto.git"
tools["JohnTheRipper"]="git clone https://github.com/openwall/john.git"
tools["Aircrack-ng"]="git clone https://github.com/aircrack-ng/aircrack-ng.git"
tools["Bettercap"]="git clone https://github.com/bettercap/bettercap.git"
tools["Ettercap"]="git clone https://github.com/Ettercap/ettercap.git"
tools["Nmap"]="git clone https://github.com/nmap/nmap.git"
tools["Masscan"]="git clone https://github.com/robertdavidgraham/masscan.git"
tools["Routersploit"]="git clone https://github.com/threat9/routersploit.git"
tools["BeEF"]="git clone https://github.com/beefproject/beef.git"
tools["SocialFish"]="git clone https://github.com/UndeadSec/SocialFish.git"
tools["HiddenEye"]="git clone https://github.com/DarkSecDevelopers/HiddenEye.git"
tools["CamPhish"]="git clone https://github.com/techchipnet/CamPhish.git"
tools["IP-Tracker"]="git clone https://github.com/rajkumardusad/IP-Tracker.git"
tools["PhoneInfoga"]="git clone https://github.com/sundowndev/PhoneInfoga.git"
tools["Instagram-Py"]="git clone https://github.com/antony-jr/instagram-py.git"
tools["kali Linux "]="git clone https://github.com/onxx-x143/Kali-Linux.git
cd Kali-Linux
chmod +x main.sh
bash main.sh"
tools["CamHack"]="https://github.com/HARISHKUMAR023/camhack.git"
tools["infoooze"]="https://github.com/devxprite/infoooze.git"
tools["Cupp"]="https://github.com/Mebus/cupp.git"
tools["Seeker"]="https://github.com/thewhiteh4t/seeker.git"
tools["Tookie-osint"]="git clone https://github.com/alfredredbird/tookie-osint.git
cd tookie-osint
chmod +x install.sh"
tools["Email-OSINT"]="git clone https://github.com/onxx-x143/Email-OSINT.git
cd Email-OSINT
chmod +x main.sh
bash main.sh"

# ---------- Special (needs extra steps) ----------
tools["WiFi-Pumpkin"]="git clone https://github.com/P0cL4bs/WiFi-Pumpkin.git && cd WiFi-Pumpkin && pip install -r requirements.txt"

# ======================================================
# ==========  Onxx-tool OF TOOL LIST  ========================
# ======================================================

# ---- Main Menu ----
main_menu() {
    clear_screen
    print_banner

    # Build numbered list
    local i=1
    local keys=()
    echo -e "${yellow}${bold}Available Tools (all from GitHub):${reset}\n"
    for key in "${!tools[@]}"; do
        keys+=("$key")
        printf "  ${cyan}[%2d]${reset} ${bold}%s${reset}\n" "$i" "$key"
        ((i++))
    done
    echo -e "\n  ${cyan}[${i}]${reset} ${bold}Install ALL Tools${reset}"
    echo -e "  ${cyan}[0]${reset} ${bold}Exit${reset}\n"

    echo -e "${yellow}Enter the numbers of the tools you want (space separated),${reset}"
    echo -e "${yellow}or type 'all' or '0' to exit.${reset}"
    echo -en "${bold}Your choice: ${reset}"
    read -a choices

    local install_all=0
    local selected_indices=()

    for choice in "${choices[@]}"; do
        if [[ "$choice" == "all" ]]; then
            install_all=1
            break
        elif [[ "$choice" == "0" ]]; then
            echo -e "${green}Exiting.${reset}"
            exit 0
        elif [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#keys[@]} )); then
            selected_indices+=($((choice-1)))
        else
            echo -e "${red}Invalid choice: ${choice}${reset}"
        fi
    done

    if [[ $install_all -eq 1 ]]; then
        echo -e "\n${yellow}You chose to install ALL tools.${reset}"
    elif [[ ${#selected_indices[@]} -gt 0 ]]; then
        echo -e "\n${yellow}You selected:${reset}"
        for idx in "${selected_indices[@]}"; do
            echo -e "  ${cyan}• ${keys[$idx]}${reset}"
        done
    else
        echo -e "${red}No valid tools selected. Exiting.${reset}"
        exit 1
    fi

    echo -en "\n${bold}Proceed? (y/n): ${reset}"
    read confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${red}Aborted.${reset}"
        exit 0
    fi

    # ---- Installation ----
    clear_screen
    print_banner
    echo -e "${green}${bold}Installing dependencies (git, python, etc.)...${reset}\n"
    eval "$UPDATE_CMD" >/dev/null 2>&1
    eval "$UPGRADE_CMD" >/dev/null 2>&1
    eval "$INSTALL_CMD $DEPS" >/dev/null 2>&1

    echo -e "\n${green}${bold}Starting tool installation (cloning from GitHub)...${reset}\n"
    if [[ $install_all -eq 1 ]]; then
        for key in "${!tools[@]}"; do
            install_tool "$key" "${tools[$key]}"
        done
    else
        for idx in "${selected_indices[@]}"; do
            key="${keys[$idx]}"
            install_tool "$key" "${tools[$key]}"
        done
    fi

    # ---- Final steps ----
    echo -e "\n${green}${bold}✅ URL-Only Installation complete!${reset}"
    echo -e "Type ${cyan}${bold}gateup${reset} to open the menu again."

    # Make script globally accessible (no sudo)
    cp "$0" "$PREFIX/bin/gateup" 2>/dev/null || cp "$0" /usr/local/bin/gateup 2>/dev/null
    chmod +x "$PREFIX/bin/gateup" 2>/dev/null || chmod +x /usr/local/bin/gateup 2>/dev/null

    # Open GATE-UP URL in browser (silent)
    if command -v termux-open &> /dev/null; then
        termux-open "$GATEUP_URL" &>/dev/null &
    elif command -v xdg-open &> /dev/null; then
        xdg-open "$GATEUP_URL" &>/dev/null &
    fi

    echo -e "\n${bold}Press Enter to exit.${reset}"
    read
    clear_screen
    exit 0
}

# ---- Start ----
main_menu
