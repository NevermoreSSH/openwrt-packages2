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
sleep 1

#-----------------------------------------------------------------------------

# install passwall , adblock , openvpn
cd /tmp
opkg update;opkg --force-overwrite install luci-app-passwall haproxy xray-core luci-app-watchcat luci-app-vnstat

# fix vnstat 
mkdir -p /etc/vnstat/
sed -i 's|DatabaseDir "/var/lib/vnstat"|DatabaseDir "/etc/vnstat"|g' /etc/vnstat.conf

# cpu set max performance
#uci set cpufreq.cpufreq.governor0='performance'
uci set cpufreq.cpufreq.governor=performance
uci set cpufreq.cpufreq.minifreq=2208000
uci commit cpufreq

# enable tcp bbr cca
#uci set turboacc.config
#uci set turboacc.config.bbr_cca=1
#uci commit turboacc

# Remove watchcat default config
uci delete watchcat.@watchcat[0]
uci commit watchcat

# sucess english preset
sed -i '/luciname/d' /usr/lib/lua/luci/version.lua
sed -i '/luciversion/d' /usr/lib/lua/luci/version.lua
echo "luciname    = \"Preset English\"" >> /usr/lib/lua/luci/version.lua
echo "luciversion    = \"V2\"" >> /usr/lib/lua/luci/version.lua

#-----------------------------------------------------------------------------

# english rooter
mv /usr/lib/lua/luci/model/cbi/rooter/customize.lua /usr/lib/lua/luci/model/cbi/rooter/customize.lua.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/customize.lua && mv customize.lua /usr/lib/lua/luci/model/cbi/rooter && chmod +x /usr/lib/lua/luci/model/cbi/rooter/customize.lua && rm *.lua

mv /usr/lib/lua/luci/view/rooter/debug.htm /usr/lib/lua/luci/view/rooter/debug.htm.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/debug.htm && mv debug.htm /usr/lib/lua/luci/view/rooter && chmod +x /usr/lib/lua/luci/view/rooter/debug.htm && rm *.htm

mv /usr/lib/lua/luci/view/rooter/misc.htm /usr/lib/lua/luci/view/rooter/misc.htm.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/misc.htm && mv misc.htm /usr/lib/lua/luci/model/cbi/rooter && chmod +x /usr/lib/lua/luci/model/cbi/rooter/customize.lua && rm *.lua

mv /usr/lib/lua/luci/controller/admin/modem.lua /usr/lib/lua/luci/controller/admin/modem.lua.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/modem.lua && mv modem.lua /usr/lib/lua/luci/controller/admin && chmod +x /usr/lib/lua/luci/controller/admin/modem.lua && rm *.lua

mv /usr/lib/lua/luci/view/modlog/modlog.htm /usr/lib/lua/luci/view/modlog/modlog.htm.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/modlog.lua && mv modlog.lua /usr/lib/lua/luci/view/modlog && chmod +x /usr/lib/lua/luci/view/modlog/modlog.htm && rm *.htm

mv /usr/lib/lua/luci/controller/modlog.lua /usr/lib/lua/luci/controller/modlog.lua.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/modlog.lua && mv modlog.lua /usr/lib/lua/luci/controller && chmod +x /usr/lib/lua/luci/controller/modlog.lua && rm *.lua

mv /usr/lib/lua/luci/view/rooter/net_status.htm /usr/lib/lua/luci/view/rooter/net_status.htm.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/net_status.htm && mv net_status.htm /usr/lib/lua/luci/view/rooter && chmod +x /usr/lib/lua/luci/view/rooter/net_status.htm && rm *.htm

mv /usr/lib/lua/luci/model/cbi/rooter/profiles.lua /usr/lib/lua/luci/model/cbi/rooter/profiles.lua.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/profiles.lua && mv profiles.lua /usr/lib/lua/luci/model/cbi/rooter && chmod +x /usr/lib/lua/luci/model/cbi/rooter/profiles.lua && rm *.lua

mv /usr/lib/lua/luci/view/rooter/sms.htm /usr/lib/lua/luci/view/rooter/sms.htm.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/sms.htm && mv sms.htm /usr/lib/lua/luci/view/rooter && chmod +x /usr/lib/lua/luci/view/rooter/sms.htm && rm *.sms.htm

mv /usr/lib/lua/luci/controller/sms.lua /usr/lib/lua/luci/controller/sms.lua.bak && curl -L https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/sms.lua && mv sms.lua /usr/lib/lua/luci/controller && chmod +x /usr/lib/lua/luci/controller/sms.lua && rm *.sms.lua

sleep 1
#-----------------------------------------------------------------------------
reboot