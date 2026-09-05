#!/bin/bash

[ -d files/usr/bin ] || mkdir -p files/usr/bin

AGH_CORE="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_${1}.tar.gz"
echo "AGH_CORE: $AGH_CORE"

# 使用 --wildcards 匹配文件夹内的二进制文件
wget -qO- $AGH_CORE | tar xOz --wildcards '*/AdGuardHome' > files/usr/bin/AdGuardHome

# 检查文件是否成功提取
if [ ! -s files/usr/bin/AdGuardHome ]; then
    echo "Error: Failed to extract AdGuardHome binary" >&2
    exit 1
fi

chmod +x files/usr/bin/AdGuardHome
echo "AdGuardHome binary installed successfully"
# 关闭 CONFIG_PACKAGE_adguardhome=y，避免冲突，改成CONFIG_PACKAGE_adguardhome=n
