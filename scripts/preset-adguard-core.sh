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
TMP_TAR=$(mktemp)

echo "Download: ${AGH_URL}"
wget -qL -O "${TMP_TAR}" "${AGH_URL}"

# 打印归档内容用于调试
tar -ztf "${TMP_TAR}"

# 方案A：匹配带 ./ 的路径
# tar -xzf "${TMP_TAR}" -O ./AdGuardHome/AdGuardHome > "${OUT_BIN}"

# 方案B（推荐）：--strip-components，兼容性最强
tar -xzf "${TMP_TAR}" --strip-components=1 AdGuardHome/AdGuardHome -O > "${OUT_BIN}"

chmod +x "${OUT_BIN}"
rm -f "${TMP_TAR}"
echo "Done -> ${OUT_BIN}"



# 关闭 CONFIG_PACKAGE_adguardhome=y，避免冲突，改成CONFIG_PACKAGE_adguardhome=n
