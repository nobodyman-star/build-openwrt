#!/bin/bash
mkdir -p "files/usr/bin"
AGH_CORE="https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_${1}.tar.gz"
wget -qO- "$AGH_CORE" | tar -xOz AdGuardHome/AdGuardHome > "files/usr/bin/AdGuardHome"
chmod +x "files/usr/bin/AdGuardHome"
# 关闭 CONFIG_PACKAGE_adguardhome=y，避免冲突，改成CONFIG_PACKAGE_adguardhome=n
