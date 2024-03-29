#!/bin/bash
#=================================================
# File name: 99-init-settings.sh
# Description: This script will be executed during the first boot
# Author: NevermoreSSH
# Contact: t.me/todfix667
#=================================================

# first boot

# add packages for vpn
echo | tee -a /etc/opkg/customfeeds.conf
echo "src/gz custom_packages https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2" | tee -a /etc/opkg/customfeeds.conf

#-----------------------------------------------------------------------------

# irqbalance core
cat << 'EOF' > /etc/irq1.sh
#/bin/sh
#script by abidarwish

interrupt=$(ls /proc/irq/ | sed '/default/d')

>/root/output.txt
for i in $interrupt; do
        CORE=$(cat /proc/irq/$i/smp_affinity)
        echo 8 > /proc/irq/${i}/smp_affinity 2>/dev/null
        printf "%-10s\t%-10s\n" "$i:" "$CORE" >>/root/output.txt
done

echo e > "/proc/irq/$(grep usb3 /proc/interrupts | awk -F: '{print $1}' | sed 's/^ //')/smp_affinity"


cat output.txt
EOF
sh /etc/irq1.sh
sleep 1

#-----------------------------------------------------------------------------

# install passwall , haproxy , xray-core , vnstat
cd /tmp
opkg update;opkg --force-overwrite install luci-app-passwall haproxy xray-core luci-app-vnstat

# cpu set max performance
#uci set cpufreq.cpufreq.governor0='performance'
uci set cpufreq.cpufreq.governor=performance
uci set cpufreq.cpufreq.minifreq=2208000
uci commit cpufreq

# fix vnstat 
mkdir -p /etc/vnstat/
sed -i 's|DatabaseDir "/var/lib/vnstat"|DatabaseDir "/etc/vnstat"|g' /etc/vnstat.conf

# sucess english preset
sed -i '/luciname/d' /usr/lib/lua/luci/version.lua
sed -i '/luciversion/d' /usr/lib/lua/luci/version.lua
echo "luciname    = \"ClashWall Preset\"" >> /usr/lib/lua/luci/version.lua
echo "luciversion    = \"EN\"" >> /usr/lib/lua/luci/version.lua

# Fixed Passwall timeout when reboot/turn on
rm -r /etc/rc.local
sleep 1

cat <<'EOF' >>/etc/opkg/distfeeds.conf
# Put your custom commands here that should be executed once
# the system init finished. By default this file does nothing.

# Restart passwall after power on
/etc/init.d/passwall restart
# Running script irqbalance
/etc/config/irq1
sh /etc/config/irq1

exit 0

EOF
sleep 1

#-----------------------------------------------------------------------------

# replace file with english language
wget -q -O /usr/lib/lua/luci/model/cbi/customize.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/customize.lua"
wget -q -O /usr/lib/lua/luci/view/rooter/debug.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/debug.htm"
wget -q -O /usr/lib/lua/luci/view/rooter/misc.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/misc.htm"
wget -q -O /usr/lib/lua/luci/controller/admin/modem.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/modem.lua"
wget -q -O /usr/lib/lua/luci/view/modlog/modlog.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/modlog.htm"
wget -q -O /usr/lib/lua/luci/controller/modlog.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/modlog.lua"
wget -q -O /usr/lib/lua/luci/view/rooter/net_status.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/net_status.htm"
wget -q -O /usr/lib/lua/luci/model/cbi/rooter/profiles.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/profiles.lua"
wget -q -O /usr/lib/lua/luci/view/rooter/sms.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/sms.htm"
wget -q -O /usr/lib/lua/luci/controller/sms.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/sms.lua"

sleep 1
#-----------------------------------------------------------------------------
reboot
