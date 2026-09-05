#!/bin/bash
set -euo pipefail
mkdir -p "files/usr/bin"

if [ -z "$1" ];then
    echo "usage: $0 amd64|arm64|armv7|386|mipsle"
    exit 1
fi

ARCH="$1"
AGH_URL="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_${ARCH}.tar.gz"
OUT_BIN="files/usr/bin/AdGuardHome"

echo "Download: ${AGH_URL}"
wget -qL -O - "${AGH_URL}" | tar -xzO AdGuardHome/AdGuardHome > "${OUT_BIN}"
chmod +x "${OUT_BIN}"
echo "Done -> ${OUT_BIN}"


# 关闭 CONFIG_PACKAGE_adguardhome=y，避免冲突，改成CONFIG_PACKAGE_adguardhome=n
