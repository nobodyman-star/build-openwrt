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
# 下载完整文件，跟随重定向
wget -qL -O "${TMP_TAR}" "${AGH_URL}"

# 列出压缩包内容（打印日志，Actions可以看到包里的文件）
tar -ztf "${TMP_TAR}"

# 单独提取二进制文件
tar -xzf "${TMP_TAR}" -O AdGuardHome/AdGuardHome > "${OUT_BIN}"

chmod +x "${OUT_BIN}"
rm -f "${TMP_TAR}"
echo "Done -> ${OUT_BIN}"



# 关闭 CONFIG_PACKAGE_adguardhome=y，避免冲突，改成CONFIG_PACKAGE_adguardhome=n
