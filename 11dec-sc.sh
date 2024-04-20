sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf;echo "src/gz custom_packages https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2" | tee -a /etc/opkg/customfeeds.conf;opkg update;opkg install luci-app-adblock luci-app-ttyd openvpn-openssl luci-app-openvpn luci-app-vnstat luci-app-3ginfo-lite;>/usr/share/passwall/rules/proxy_ip;>/usr/share/passwall/rules/proxy_host;>/usr/share/passwall/rules/domains_excluded;>/usr/share/passwall/rules/direct_ip;>/usr/share/passwall/rules/direct_host;>/usr/share/passwall/rules/block_ip;>/usr/share/passwall/rules/block_host;>/usr/share/passwall/rules/gfwlist;>/usr/share/passwall/rules/chnroute6;>/usr/share/passwall/rules/chnroute;>/usr/share/passwall/rules/chnlist;uci delete watchcat.@watchcat[0];uci commit watchcat;uci set sms_tool.general.storage='ME';uci commit sms_tool;uci set 3ginfo.@3ginfo[0].network='wan';uci set 3ginfo.@3ginfo[0].device='/dev/ttyUSB1';uci commit 3ginfo;uci set network.OpenVPN=interface;uci set network.OpenVPN.proto='none';uci set network.OpenVPN.device='tun0';uci add_list firewall.@zone[1].network='OpenVPN';uci commit firewall;mkdir -p /etc/vnstat/;sed -i 's|DatabaseDir "/var/lib/vnstat"|DatabaseDir "/etc/vnstat"|g' /etc/vnstat.conf;/etc/init.d/vnstat restart;echo '#Reboot Router Every Week 5AM Sunday' | tee -a /etc/crontabs/root;echo "0 5 * * 0 reboot" | tee -a /etc/crontabs/root;echo '#Adblock Reload Every Hour' | tee -a /etc/crontabs/root;echo "0 * * * * /etc/init.d/adblock reload" | tee -a /etc/crontabs/root;echo "ip6tables -t mangle -I POSTROUTING -o wwan0 -j HL --hl-set 64" | tee -a /etc/firewall.user;echo "ip6tables -t mangle -I PREROUTING -i wwan0 -j HL --hl-set 64" | tee -a /etc/firewall.user;wget -q -O /usr/lib/ModemManager/connection.d/10-report-down "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/11dec-updatedmm";wget -q -O /etc/rc.local "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/11dec-rc.local";wget -q -O /etc/banner "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/11dec-banner";wget -q -O /etc/config/passwall "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/11dec-passwall";wget -q -O /etc/config/shadowsocksr "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_presetv2/11dec-ssrplus";reboot
