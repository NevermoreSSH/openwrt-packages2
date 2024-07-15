wget -q -O /usr/lib/lua/luci/view/rooter/net_status.htm "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/net_status.htm";
wget -q -O /etc/opkg/distfeeds.conf "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/distfeeds.conf";
wget -q -O /etc/firewall.user "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/firewall.user";
opkg update;opkg install luci-app-vnstat luci-app-adblock luci-app-watchcat;
mkdir -p /etc/vnstat/;sed -i 's|DatabaseDir "/var/lib/vnstat"|DatabaseDir "/etc/vnstat"|g' /etc/vnstat.conf;/etc/init.d/vnstat restart;
sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf;
echo '#Adblock Reload Every 1Hour' | tee -a /etc/crontabs/root;
echo "1 * * * * /etc/init.d/adblock reload" | tee -a /etc/crontabs/root;
uci delete watchcat.@watchcat[0];
uci commit watchcat;
uci set dhcp.lan.leasetime='168h';
uci commit dhcp;
uci set firewall.@defaults[0].flow_offloading='0';
uci set firewall.@defaults[0].flow_offloading_hw='0';
uci commit firewall;
/etc/init.d/firewall restart;
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
echo "All scripts installed. Thank you!";
reboot
