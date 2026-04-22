# Kioptrix Level 1 — TCM Research Notes

> Authorized lab research and educational documentation for the Kioptrix Level 1 machine from VulnHub.
> All findings are documented for learning purposes only.

---

## 🌐 Live Notes

**[View the full interactive notes here](https://artinmeraji.github.io/tcm-resaerch-note-/)**

---

## Target Info

| Field | Value |
|-------|-------|
| Target IP | 192.168.57.134 |
| Hostname | KIOPTRIX |
| OS | Linux 2.4.x (Red Hat) |
| Platform | VulnHub — Kioptrix Level 1 |
| Purpose | Authorized lab research |

---

## Open Ports

| Port | Service | Version | Risk |
|------|---------|---------|------|
| 22/tcp | SSH | OpenSSH 2.9p2 | Medium |
| 80/tcp | HTTP | Apache 1.3.20 + mod_ssl 2.8.4 | Critical |
| 111/tcp | rpcbind | v2 | Medium |
| 139/tcp | SMB | Samba 2.2.1a | Critical |
| 443/tcp | HTTPS | Apache 1.3.20 + SSLv2 | Critical |

---

## Notes

### 📊 [Hack Dashboard](https://artinmeraji.github.io/tcm-resaerch-note-/dashboard.html)
Full recon dashboard covering all discovered services. Includes the raw nmap output, SMB enumeration results, msfconsole workflow, and a prioritized attack surface breakdown. Built with a dark Monokai Pro color scheme.

### 🔑 [SSH Notes](https://artinmeraji.github.io/tcm-resaerch-note-/ssh_notes.html)
Covers what SSH is, why we probed it, and a step-by-step log of every connection attempt. Each failed probe is explained — what went wrong, which flag was missing, and why. The final working command is broken down flag by flag. DedSec / Watch Dogs aesthetic.

### 🔬 [Lab Notes](https://artinmeraji.github.io/tcm-resaerch-note-/lab_notes.html)
Version documentation and service analysis. Covers the Apache/mod_ssl/OpenSSL stack, SSLv2 exposure, HTTP method disclosure, Samba version correlation, smbclient output, and searchsploit findings.

### 🧠 [Analysis Notes](https://artinmeraji.github.io/tcm-resaerch-note-/analysis_notes.html)
Ten-section breakdown of what the scan data actually means. Covers how to interpret version correlation, how to write about findings academically, the difference between a research lead and confirmed exploitability, and the analyst mindset vs the movie hacker mindset.

### 🖥️ [Wallpaper](https://artinmeraji.github.io/tcm-resaerch-note-/wallpaper.html)
Animated hacking wallpaper built on HTML canvas. Features matrix code rain in purple and pink, network node map, glitch effects, and HUD elements pulled from the scan data. Open full screen and screenshot to use as a desktop wallpaper.

---

## Raw Files

| File | Description |
|------|-------------|
| `nmap_192.168.1.184.txt` | Raw nmap scan output — `-T4 -p- -A` |
| `attack_analysis.txt` | Port-by-port attack surface breakdown |
| `notes.txt` | ASCII art study notes — msfconsole and SMB |
| `notes.sh` | Colored terminal notes — run with `bash notes.sh` |

---

## Key Findings

**mod_ssl / OpenFuck — port 443**
Apache 1.3.20 with mod_ssl 2.8.4 is within the documented range for CVE-2002-0082. Historical public research documents a remote buffer overflow affecting this version combination.

**Samba trans2open — port 139**
Samba 2.2.1a was confirmed via the smb_version auxiliary module. This version falls within the documented range for CVE-2003-0201. Anonymous login to IPC$ was confirmed with no credentials required.

**Information Disclosure**
Server headers disclose the full software stack. The default Apache test page is visible. Webalizer stats are publicly accessible. SSLv2 is enabled on port 443 with broken cipher suites.

---

## Tools Referenced

- `nmap` — port scanning and service detection
- `msfconsole` — Metasploit Framework
- `smbclient` — SMB enumeration
- `enum4linux` — full SMB enumeration
- `searchsploit` — local exploit database search
- `nikto` — web server scanning
- `hydra` — credential brute forcing

---

## Disclaimer

These notes are for **authorized lab research and educational purposes only**.
The Kioptrix machine is a deliberately vulnerable VM from VulnHub designed for learning.
Do not use any of the techniques documented here against systems you do not own or have explicit written permission to test.

---

*TCM Security Lab · Kioptrix Level 1 · VulnHub*
