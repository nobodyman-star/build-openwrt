#!/bin/bash

[ -d files/usr/bin ] || mkdir -p files/usr/bin

AGH_CORE="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_${1}.tar.gz"
echo "AGH_CORE: $AGH_CORE"

# 方法1：先下载到临时文件，再提取（最可靠）
tmp_file=$(mktemp)
wget -qO "$tmp_file" "$AGH_CORE"

# 列出压缩包内容，查看实际路径
tar -tzf "$tmp_file" | grep AdGuardHome

# 提取二进制文件（使用 --strip-components 去除顶层目录）
tar -xzf "$tmp_file" -C files/usr/bin --strip-components=1 */AdGuardHome

rm -f "$tmp_file"

# 检查文件是否成功提取
if [ ! -s files/usr/bin/AdGuardHome ]; then
    echo "Error: Failed to extract AdGuardHome binary" >&2
    exit 1
fi

chmod +x files/usr/bin/AdGuardHome
echo "AdGuardHome binary installed successfully"
# 关闭 CONFIG_PACKAGE_adguardhome=y，避免冲突，改成CONFIG_PACKAGE_adguardhome=n
