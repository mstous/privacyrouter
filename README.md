# OpenWrt UniFi Clone Setup (Low-Space Router)
Tailscale VPN + SQM + BanIP + Adblock + DNS Security (~15MB total)

## Features
✅ UniFi-like LuCI dashboard
✅ Tailscale VPN (remote access)
✅ SQM QoS (bufferbloat fix)
✅ BanIP (malware IP blocks)
✅ Adblock (light lists: 85% coverage)
✅ DoH (DNS privacy)
✅ NTP sync
✅ Backup/restore

## Requirements
OpenWrt 25.12+ (apk package manager)

20MB+ free space

Tailscale auth key

# 🚀 Quick Install
## SSH to router from your desktop
`ssh root@192.168.1.1`

## Download + run setup
`wget -O setup.sh "https://raw.githubusercontent.com/mstous/privacyrouter/refs/heads/main/setup.sh"`

`wget -O backup.sh "https://raw.githubusercontent.com/mstous/privacyrouter/refs/heads/main/backup.sh"`

`wget -O restore.sh "https://raw.githubusercontent.com/mstous/privacyrouter/refs/heads/main/restore.sh"`

`chmod +x setup.sh backup.sh restore.sh`

`./setup.sh`

## After reboot (4 manual steps):
`tailscale up --authkey=tskey-YOUR-KEY`

LuCI > Network > SQM QoS → WAN → 85% ISP speeds → Save

LuCI > Services > HTTPS DNS Proxy → Cloudflare → Save

`./backup.sh`

# 💾 Backup/Restore

## Backup
`./backup.sh` (first backup)

`scp root@192.168.1.1:/tmp/config-backup-*.tar.gz ~/Downloads/`

## Restore (upload first)
`scp config-backup-*.tar.gz root@192.168.1.1:/tmp/`

`ssh root@192.168.1.1 "./restore.sh config-backup-YYYYMMDD-HHMM.tar.gz"`

# 🧪 Status Check
`df -h /`                          # Space

`tailscale status`                # VPN

`/etc/init.d/banip status`         # Security

`/etc/init.d/adblock status`       # Ads

# 📈 LuCI Dashboard Paths
Network > SQM QoS (bufferbloat)

Services > Tailscale (VPN)

Services > BanIP (threats)

Services > Adblock (ads)

Services > HTTPS DNS Proxy (DoH)

