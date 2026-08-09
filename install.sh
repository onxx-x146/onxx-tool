#!/bin/bash
# ================================================================
# GATE-UP v7.0 - Ultimate Tool Installer (Fixed & Enhanced)
# Features: Search, Categories, Fast Clone, Progress Tracking
# ================================================================

set -e

# ---- Colors ----
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
B='\033[0;34m'
M='\033[0;35m'
C='\033[0;36m'
W='\033[1;37m'
D='\033[0;90m'
RESET='\033[0m'
BOLD='\033[1m'

# ---- Config ----
INSTALL_DIR="$HOME/GATE-UP-Tools"
mkdir -p "$INSTALL_DIR"
LOG="$INSTALL_DIR/.install.log"
> "$LOG"

# ---- Detect System ----
if command -v pkg &>/dev/null; then
    SYS="termux"
    PKG="pkg install -y"
    DEPS="git curl wget python python-pip ruby php nodejs-lts golang figlet toilet"
elif command -v apt &>/dev/null; then
    SYS="kali"
    PKG="apt install -y"
    DEPS="git curl wget python3 python3-pip ruby php nodejs golang figlet toilet build-essential cmake golang-go"
else
    echo -e "${R}Unsupported system!${RESET}"
    exit 1
fi

# ---- Tool Database (Ordered Array) ----
# Format: NAME|CATEGORY|URL|POST_INSTALL|DESCRIPTION
declare -a DB=(
# --- OSINT ---
"Maigret|OSINT|https://github.com/soxoj/maigret.git|pip3 install -r maigret/requirements.txt|Username OSINT hunter"
"Sherlock|OSINT|https://github.com/sherlock-project/sherlock.git|pip3 install -r sherlock/requirements.txt|Social media account finder"
"theHarvester|OSINT|https://github.com/laramies/theHarvester.git|pip3 install -r theHarvester/requirements/base.txt|Email & subdomain gatherer"
"Recon-ng|OSINT|https://github.com/lanmaster53/recon-ng.git|pip3 install -r recon-ng/REQUIREMENTS|Web reconnaissance framework"
"OSINT-Framework|OSINT|https://github.com/lockfale/OSINT-Framework.git|echo 'Ready'|OSINT resources collection"
"PhoneInfoga|OSINT|https://github.com/sundowndev/PhoneInfoga.git|cd PhoneInfoga && go build -o phoneinfoga .|Advanced phone number OSINT"
"IP-Tracker|OSINT|https://github.com/rajkumardusad/IP-Tracker.git|cd IP-Tracker && chmod +x install && bash install|IP tracking tool"
"infoooze|OSINT|https://github.com/devxprite/infoooze.git|cd infoooze && npm install|GitHub/Domain/IP OSINT"
"Seeker|OSINT|https://github.com/thewhiteh4t/seeker.git|cd seeker && chmod +x install.sh && bash install.sh|High accuracy geolocation"
"Tookie-OSINT|OSINT|https://github.com/alfredredbird/tookie-osint.git|cd tookie-osint && chmod +x install.sh && bash install.sh|Multi-platform OSINT"
"Email-OSINT|OSINT|https://github.com/onxx-x143/Email-OSINT.git|cd Email-OSINT && chmod +x main.sh && bash main.sh|Email investigation tool"
# --- Phishing ---
"Zphisher|Phishing|https://github.com/htr-tech/zphisher.git|cd zphisher && chmod +x zphisher.sh|Automated phishing tool"
"SocialFish|Phishing|https://github.com/UndeadSec/SocialFish.git|pip3 install -r SocialFish/requirements.txt|Phishing framework"
"HiddenEye|Phishing|https://github.com/DarkSecDevelopers/HiddenEye.git|pip3 install -r HiddenEye/requirements.txt|Modern phishing tool"
"CamPhish|Phishing|https://github.com/techchipnet/CamPhish.git|cd CamPhish && chmod +x camphish.sh|Camera phishing tool"
# --- Scanning ---
"Nmap|Scanning|https://github.com/nmap/nmap.git|cd nmap && ./configure && make && make install|Network discovery scanner"
"Masscan|Scanning|https://github.com/robertdavidgraham/masscan.git|cd masscan && make|Fast TCP port scanner"
"Nikto|Scanning|https://github.com/sullo/nikto.git|echo 'Ready - cd nikto/program'|Web server vulnerability scanner"
"WPScan|Scanning|https://github.com/wpscanteam/wpscan.git|cd wpscan && gem install wpscan|WordPress security scanner"
"Dirb|Scanning|https://github.com/v0re/dirb.git|cd dirb && ./configure && make && make install|Web content scanner"
"Gobuster|Scanning|https://github.com/OJ/gobuster.git|cd gobuster && go build|Directory/DNS busting tool"
# --- Exploitation ---
"SQLMap|Exploitation|https://github.com/sqlmapproject/sqlmap.git|pip3 install -r sqlmap/requirements.txt|Automatic SQL injection"
"XSStrike|Exploitation|https://github.com/s0md3v/XSStrike.git|pip3 install -r XSStrike/requirements.txt|Advanced XSS detection"
"BeEF|Exploitation|https://github.com/beefproject/beef.git|cd beef && ./install|Browser exploitation framework"
"Routersploit|Exploitation|https://github.com/threat9/routersploit.git|pip3 install -r routersploit/requirements.txt|Router exploitation"
# --- Passwords ---
"JohnTheRipper|Passwords|https://github.com/openwall/john.git|cd john/src && ./configure && make|Password cracking tool"
"Hydra|Passwords|https://github.com/onxx-x143/Hydra.git|cd Hydra && chmod +x *|Login brute forcer"
"Cupp|Passwords|https://github.com/Mebus/cupp.git|echo 'Ready - cd cupp'|Password list generator"
# --- Wireless ---
"Aircrack-ng|Wireless|https://github.com/aircrack-ng/aircrack-ng.git|cd aircrack-ng && autoreconf -i && ./configure && make && make install|WiFi security auditing"
"Wifiphisher|Wireless|https://github.com/wifiphisher/wifiphisher.git|cd wifiphisher && python3 setup.py install|Rogue WiFi AP"
"WiFi-Pumpkin|Wireless|https://github.com/P0cL4bs/WiFi-Pumpkin.git|pip3 install -r WiFi-Pumpkin/requirements.txt|Rogue AP framework"
"Bettercap|Wireless|https://github.com/bettercap/bettercap.git|cd bettercap && make build && make install|Network attacks & monitoring"
"Ettercap|Wireless|https://github.com/Ettercap/ettercap.git|cd ettercap && mkdir -p build && cd build && cmake .. && make|MITM attacks"
# --- Utilities ---
"Xteam|Utilities|https://github.com/xploitstech/Xteam.git|cd Xteam && chmod +x *|Multi-tool suite"
"Doxxer-Toolkit|Utilities|https://github.com/Euronymou5/Doxxer-Toolkit.git|cd Doxxer-Toolkit && chmod +x * && bash install.sh|OSINT toolkit"
"KitHack|Utilities|https://github.com/AdrMXR/KitHack.git|cd KitHack && bash install.sh|Hacking tools kit"
"Spartan|Utilities|https://github.com/sensepost/spartan.git|pip3 install -r spartan/requirements.txt|Nmap + Nikto wrapper"
"CamHack|Utilities|https://github.com/HARISHKUMAR023/camhack.git|cd camhack && chmod +x *|Camera security tool"
"Kali-Linux|Utilities|https://github.com/onxx-x143/Kali-Linux.git|cd Kali-Linux && chmod +x main.sh && bash main.sh|Kali Linux scripts"
# --- Onxx-x143 Tools ---
"APKTOOL|Onxx|https://github.com/onxx-x143/APKTOOL-.git|cd APKTOOL- && chmod +x *|APK manipulation tool"
"PDF-TOOL|Onxx|https://github.com/onxx-x143/PDF-TOOL.git|cd PDF-TOOL && chmod +x *|PDF utilities"
"Onxx|Onxx|https://github.com/onxx-x143/Onxx.git|cd Onxx && chmod +x *|Onxx multi-tool"
"URL-8080|Onxx|https://github.com/onxx-x143/URL--8080.git|cd URL--8080 && chmod +x *|URL manipulation tool"
"Termux-Banner|Onxx|https://github.com/onxx-x143/Termux-pro-banner.git|cd Termux-pro-banner && chmod +x * && bash t-ban.sh|Termux custom banner"
# --- Other ---
"Instagram-Py|Other|https://github.com/antony-jr/instagram-py.git|pip3 install -r instagram-py/requirements.txt|Instagram security testing"
)

# ---- Helper Functions ----
header() {
    clear
    echo -e "${C}${BOLD}"
    cat << "EOF"
   ▄████████  ▄█   ▄█          ▄████████ ████████▄     ▄████████ 
  ███    ███ ███  ███         ███    ███ ███   ▀███   ███    ███ 
  ███    █▀  ███▌ ███         ███    █▀  ███    ███   ███    █▀  
  ███        ███▌ ███        ▄███▄▄▄     ███    ███  ▄███▄▄▄     
▀███████████ ███▌ ███       ▀▀███▀▀▀     ███    ███ ▀▀███▀▀▀     
         ███ ███  ███         ███    █▄  ███    ███   ███    █▄  
   ▄█    ███ ███  ███▌    ▄   ███    ███ ███   ▄███   ███    ███ 
 ▄████████▀  █▀   █████▄▄██   ██████████ ████████▀    ██████████ 
EOF
    echo -e "${RESET}"
    echo -e "${Y}${BOLD}         🚀  GATE-UP v7.0 - Ultimate Installer  🚀${RESET}"
    echo -e "${M}         Fast • Searchable • Categorized • Fixed${RESET}"
    echo ""
}

line() { echo -e "${D}────────────────────────────────────────────────────────────${RESET}"; }

# ---- Install Dependencies ----
install_deps() {
    echo -e "${Y}${BOLD}[*] Installing dependencies...${RESET}"
    if [ "$SYS" = "termux" ]; then
        pkg update -y >/dev/null 2>&1
    else
        apt update -y >/dev/null 2>&1
    fi
    eval "$PKG $DEPS" >/dev/null 2>&1
    echo -e "${G}${BOLD}[✓] Dependencies ready!${RESET}\n"
}

# ---- Parse Tool ----
get_name()   { echo "$1" | cut -d'|' -f1; }
get_cat()    { echo "$1" | cut -d'|' -f2; }
get_url()    { echo "$1" | cut -d'|' -f3; }
get_post()   { echo "$1" | cut -d'|' -f4; }
get_desc()   { echo "$1" | cut -d'|' -f5; }

# ---- Install Single Tool ----
install_one() {
    local entry="$1"
    local name=$(get_name "$entry")
    local url=$(get_url "$entry")
    local post=$(get_post "$entry")
    local dir=$(echo "$url" | sed 's/.*\///g; s/\.git//g')

    echo -e "${B}→${RESET} ${BOLD}$name${RESET} ${D}(cloning...)${RESET}"

    if [ -d "$INSTALL_DIR/$dir" ]; then
        echo -e "  ${Y}⚠ Already exists, skipping clone${RESET}"
    else
        if git clone --depth 1 "$url" "$INSTALL_DIR/$dir" >> "$LOG" 2>&1; then
            echo -e "  ${G}✓ Cloned${RESET}"
        else
            echo -e "  ${R}✗ Clone failed${RESET}"
            return 1
        fi
    fi

    if [ -n "$post" ] && [ "$post" != "echo 'Ready'" ] && [ "$post" != "echo 'Ready - cd nikto/program'" ] && [ "$post" != "echo 'Ready - cd cupp'" ]; then
        echo -e "  ${B}⚙ Setting up...${RESET}"
        cd "$INSTALL_DIR"
        if eval "$post" >> "$LOG" 2>&1; then
            echo -e "  ${G}✓ Setup complete${RESET}"
        else
            echo -e "  ${Y}⚠ Setup had issues (check $LOG)${RESET}"
        fi
    fi
    echo ""
}

# ---- Search Tools ----
search_tools() {
    header
    echo -e "${C}${BOLD}[🔍 SEARCH MODE]${RESET}"
    echo -en "${Y}Enter tool name to search: ${RESET}"
    read query

    if [ -z "$query" ]; then return; fi

    local matches=()
    local i=0
    for entry in "${DB[@]}"; do
        local name=$(get_name "$entry")
        local cat=$(get_cat "$entry")
        if echo "$name $cat" | grep -iq "$query"; then
            matches+=("$entry")
            echo -e "  ${G}[$((i+1))]${RESET} ${BOLD}$name${RESET} ${D}($cat)${RESET}"
            echo -e "      ${D}$(get_desc "$entry")${RESET}"
            ((i++))
        fi
    done

    if [ ${#matches[@]} -eq 0 ]; then
        echo -e "\n${R}No tools found matching '$query'${RESET}"
        sleep 1
        return
    fi

    echo -e "\n${Y}Enter numbers to install (space-separated), 'all', or 0 to cancel:${RESET}"
    echo -en "${BOLD}Choice: ${RESET}"
    read choices

    [ "$choices" = "0" ] && return

    local to_install=()
    if [ "$choices" = "all" ]; then
        to_install=("${matches[@]}")
    else
        for c in $choices; do
            if [ "$c" -ge 1 ] && [ "$c" -le ${#matches[@]} ] 2>/dev/null; then
                to_install+=("${matches[$((c-1))]}")
            fi
        done
    fi

    if [ ${#to_install[@]} -gt 0 ]; then
        echo -e "\n${Y}${BOLD}[*] Installing ${#to_install[@]} tool(s)...${RESET}\n"
        cd "$INSTALL_DIR"
        for entry in "${to_install[@]}"; do
            install_one "$entry"
        done
        echo -e "${G}${BOLD}[✓] Done!${RESET}"
        sleep 1
    fi
}

# ---- Category View ----
category_view() {
    while true; do
        header
        echo -e "${C}${BOLD}[📂 CATEGORIES]${RESET}\n"

        local cats=()
        for entry in "${DB[@]}"; do
            local c=$(get_cat "$entry")
            if [[ ! " ${cats[@]} " =~ " $c " ]]; then
                cats+=("$c")
            fi
        done

        local i=1
        for c in "${cats[@]}"; do
            local count=0
            for entry in "${DB[@]}"; do
                [ "$(get_cat "$entry")" = "$c" ] && ((count++))
            done
            printf "  ${G}[%d]${RESET} %-15s ${D}(%d tools)${RESET}\n" "$i" "$c" "$count"
            ((i++))
        done
        echo -e "  ${R}[0]${RESET} Back"
        echo -en "\n${Y}Select category: ${RESET}"
        read cchoice

        [ "$cchoice" = "0" ] && break

        if [ "$cchoice" -ge 1 ] && [ "$cchoice" -le ${#cats[@]} ] 2>/dev/null; then
            local selcat="${cats[$((cchoice-1))]}"

            header
            echo -e "${C}${BOLD}[📂 $selcat Tools]${RESET}\n"
            local cat_tools=()
            local j=1
            for entry in "${DB[@]}"; do
                if [ "$(get_cat "$entry")" = "$selcat" ]; then
                    cat_tools+=("$entry")
                    printf "  ${G}[%2d]${RESET} %-20s ${D}%s${RESET}\n" "$j" "$(get_name "$entry")" "$(get_desc "$entry")"
                    ((j++))
                fi
            done

            echo -e "\n${Y}Enter numbers to install (space-separated), 'all', or 0 to cancel:${RESET}"
            echo -en "${BOLD}Choice: ${RESET}"
            read choices
            [ "$choices" = "0" ] && continue

            local to_install=()
            if [ "$choices" = "all" ]; then
                to_install=("${cat_tools[@]}")
            else
                for c in $choices; do
                    if [ "$c" -ge 1 ] && [ "$c" -le ${#cat_tools[@]} ] 2>/dev/null; then
                        to_install+=("${cat_tools[$((c-1))]}")
                    fi
                done
            fi

            if [ ${#to_install[@]} -gt 0 ]; then
                echo -e "\n${Y}${BOLD}[*] Installing ${#to_install[@]} tool(s)...${RESET}\n"
                cd "$INSTALL_DIR"
                for entry in "${to_install[@]}"; do
                    install_one "$entry"
                done
                echo -e "${G}${BOLD}[✓] Category installation complete!${RESET}"
                echo -en "\n${D}Press Enter to continue...${RESET}"
                read
            fi
        fi
    done
}

# ---- Full List View ----
full_list_view() {
    header
    echo -e "${C}${BOLD}[📋 ALL TOOLS]${RESET} ${D}(${#DB[@]} total)${RESET}\n"

    local i=1
    for entry in "${DB[@]}"; do
        printf "  ${G}[%2d]${RESET} %-20s ${D}%-12s %s${RESET}\n" "$i" "$(get_name "$entry")" "[$(get_cat "$entry")]" "$(get_desc "$entry")"
        ((i++))
    done

    echo -e "\n${Y}Enter numbers to install (space-separated), 'all', or 0 to cancel:${RESET}"
    echo -en "${BOLD}Choice: ${RESET}"
    read choices
    [ "$choices" = "0" ] && return

    local to_install=()
    if [ "$choices" = "all" ]; then
        to_install=("${DB[@]}")
    else
        for c in $choices; do
            if [ "$c" -ge 1 ] && [ "$c" -le ${#DB[@]} ] 2>/dev/null; then
                to_install+=("${DB[$((c-1))]}")
            fi
        done
    fi

    if [ ${#to_install[@]} -gt 0 ]; then
        echo -e "\n${Y}${BOLD}[*] Installing ${#to_install[@]} tool(s)...${RESET}\n"
        cd "$INSTALL_DIR"
        for entry in "${to_install[@]}"; do
            install_one "$entry"
        done
        echo -e "${G}${BOLD}[✓] Installation complete!${RESET}"
        echo -en "\n${D}Press Enter to continue...${RESET}"
        read
    fi
}

# ---- Install All ----
install_all() {
    header
    echo -e "${R}${BOLD}[!] This will install ALL ${#DB[@]} tools!${RESET}"
    echo -e "${Y}Install directory: $INSTALL_DIR${RESET}"
    echo -en "\n${BOLD}Are you sure? (yes/no): ${RESET}"
    read confirm
    if [ "$confirm" != "yes" ]; then
        echo -e "${R}Aborted.${RESET}"
        sleep 1
        return
    fi

    install_deps
    echo -e "\n${Y}${BOLD}[*] Starting mass installation...${RESET}\n"
    cd "$INSTALL_DIR"
    local count=0
    for entry in "${DB[@]}"; do
        ((count++))
        echo -e "${C}${BOLD}[$count/${#DB[@]}]${RESET}"
        install_one "$entry"
    done
    echo -e "${G}${BOLD}[✓] All tools installed!${RESET}"
    echo -en "\n${D}Press Enter to continue...${RESET}"
    read
}

# ---- Main Menu ----
main_menu() {
    while true; do
        header
        echo -e "  ${G}[1]${RESET} ${BOLD}Search Tools${RESET}      ${D}Find by name${RESET}"
        echo -e "  ${G}[2]${RESET} ${BOLD}Categories${RESET}        ${D}Browse by type${RESET}"
        echo -e "  ${G}[3]${RESET} ${BOLD}Full List${RESET}         ${D}See all ${#DB[@]} tools${RESET}"
        echo -e "  ${G}[4]${RESET} ${BOLD}Install All${RESET}       ${D}One-click install${RESET}"
        echo -e "  ${G}[5]${RESET} ${BOLD}Install Dependencies${RESET} ${D}git, python, etc.${RESET}"
        echo -e "  ${R}[0]${RESET} ${BOLD}Exit${RESET}"
        line
        echo -en "\n${Y}${BOLD}Select option: ${RESET}"
        read choice

        case "$choice" in
            1) search_tools ;;
            2) category_view ;;
            3) full_list_view ;;
            4) install_all ;;
            5) install_deps ; echo -en "\n${D}Press Enter...${RESET}"; read ;;
            0) echo -e "\n${G}Goodbye!${RESET}"; exit 0 ;;
            *) echo -e "${R}Invalid option${RESET}"; sleep 0.5 ;;
        esac
    done
}

# ---- Self-Install ----
self_install() {
    if [ "$SYS" = "termux" ] && [ -n "$PREFIX" ]; then
        cp "$0" "$PREFIX/bin/gateup" 2>/dev/null && chmod +x "$PREFIX/bin/gateup"
    else
        cp "$0" /usr/local/bin/gateup 2>/dev/null && chmod +x /usr/local/bin/gateup
    fi
}

# ---- Run ----
self_install
main_menu
