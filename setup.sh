#!/bin/sh
# Complete UniFi-like OpenWrt setup (April 2026)
# Low-space optimized

set -e  # Exit on error

echo "=== 1. Updating package lists ==="
apk update

echo "=== 2. Core LuCI ==="
apk add luci luci-ssl luci-app-firewall luci-app-attendedsysupgrade

echo "=== 3. SQM QoS ==="
apk add luci-app-sqm sqm-scripts

echo "=== 4. Security (BanIP + Adblock) ==="
apk add luci-app-banip banip luci-app-adblock adblock

echo "=== 5. Tailscale VPN ==="
apk add tailscale luci-app-tailscale-community coreutils-base64

echo "=== 6. DNS security ==="
apk add luci-app-https-dns-proxy https-dns-proxy

echo "=== 7. NTP + monitoring ==="
apk add sysntpd luci-app-ntpc

echo "=== 8. Enabling ALL services ==="
for service in banip adblock sqm https-dns-proxy sysntpd; do
    /etc/init.d/$service enable
    /etc/init.d/$service start
done

echo "=== 9. Adblock lightweight lists ==="
cat > /etc/adblock/adblock.sources << 'EOF'
hagezi-light=https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/light.txt
oisd-basic=https://big.oisd.nl
stevenblack=https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
EOF

echo "=== 10. MANUAL steps after reboot ==="
echo ""
echo "1. tailscale up --authkey=YOUR-TAILSCALE-KEY"
echo "2. LuCI > Network > SQM QoS > WAN > 85% speeds > Save&Apply"
echo "3. LuCI > Services > HTTPS DNS Proxy > Cloudflare > Save&Apply"
echo "4. Run backup.sh"
echo ""
echo "=== Rebooting in 10 seconds ==="
sleep 10
reboot
