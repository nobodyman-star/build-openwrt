#!/bin/bash
set -e
mkdir -p "files/usr/bin"
if [ -z "$1" ];then
    echo "usage: $0 amd64|arm64|armv7|386|mipsle"
    exit 1
fi
ARCH="$1"
AGH_URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_${ARCH}.tar.gz"
echo "Download: ${AGH_URL}"
wget -qL -O - "${AGH_URL}" | tar -xO AdGuardHome/AdGuardHome > files/usr/bin/AdGuardHome
chmod +x files/usr/bin/AdGuardHome
echo "Done -> files/usr/bin/AdGuardHome"

# 关闭 CONFIG_PACKAGE_adguardhome=y，避免冲突，改成CONFIG_PACKAGE_adguardhome=n
