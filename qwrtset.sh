echo "src/gz custom_packages https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2" | tee -a /etc/opkg/customfeeds.conf;
opkg update;opkg install luci-app-passwall htop haproxy xray-core luci-app-vnstat;
uci set cpufreq.cpufreq.governor=performance;
uci set cpufreq.cpufreq.minifreq=2208000;
uci commit cpufreq;
uci set turboacc.config.bbr_cca=1;
uci commit turboacc;
uci set luci.main.lang='auto';
uci commit luci.main;
mkdir -p /etc/vnstat/;sed -i 's|DatabaseDir "/var/lib/vnstat"|DatabaseDir "/etc/vnstat"|g' /etc/vnstat.conf;/etc/init.d/vnstat restart;
>/usr/share/passwall/rules/proxy_ip;
>/usr/share/passwall/rules/proxy_host;
>/usr/share/passwall/rules/domains_excluded;
>/usr/share/passwall/rules/direct_ip;
>/usr/share/passwall/rules/direct_host;
>/usr/share/passwall/rules/block_ip;
>/usr/share/passwall/rules/block_host;
>/usr/share/passwall/rules/gfwlist;
>/usr/share/passwall/rules/chnroute6;
>/usr/share/passwall/rules/chnroute;
>/usr/share/passwall/rules/chnlist;
wget -q -O /usr/lib/lua/luci/model/cbi/rooter/customize.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/customize.lua";
wget -q -O /usr/lib/lua/luci/view/rooter/debug.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/debug.htm";
wget -q -O /usr/lib/lua/luci/view/rooter/misc.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/misc.htm";
wget -q -O /usr/lib/lua/luci/controller/admin/modem.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/modem.lua";
wget -q -O /usr/lib/lua/luci/view/modlog/modlog.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/modlog.htm";
wget -q -O /usr/lib/lua/luci/controller/modlog.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/modlog.lua";
wget -q -O /usr/lib/lua/luci/view/rooter/net_status.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/net_status.htm";
wget -q -O /usr/lib/lua/luci/model/cbi/rooter/profiles.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/profiles.lua";
wget -q -O /usr/lib/lua/luci/view/rooter/sms.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/sms.htm";
wget -q -O /usr/lib/lua/luci/controller/sms.lua "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/sms.lua";
wget -q -O /usr/lib/lua/luci/view/rooter/custom.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/custom.htm";
wget -q -O /etc/rc.local "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/rc.local";
wget -q -O /etc/config/irq1 "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/irq1_4";
wget -q -O /etc/hotplug.d/iface/99-passwall "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/99-passwall";
wget -q -O /etc/banner "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/banner";
reboot
