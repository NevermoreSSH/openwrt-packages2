sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='OpenWrt SNAPSHOT by SolomonRicky (11Dec - SC Fixed V1.1)'/g" /etc/openwrt_release;
sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf;
echo "src/gz custom_packages https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_11dec_owrt" | tee -a /etc/opkg/customfeeds.conf;
opkg update;opkg install luci-app-3ginfo-lite;
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
uci delete watchcat.@watchcat[0];
uci commit watchcat;
#uci set sms_tool.general.storage='ME';
sed -i '/Openwrt/d' /etc/config/phonebook.user;
echo 'Example Number Openwrt user;60123456789' | tee -a /etc/config/phonebook.user;
uci set sms_tool.general.pnumber='6';
uci commit sms_tool;
uci set 3ginfo.@3ginfo[0].network='wan';
uci set 3ginfo.@3ginfo[0].device='/dev/ttyUSB1';
uci commit 3ginfo;
echo '#Reboot Router Every Week 5AM Sunday' | tee -a /etc/crontabs/root;
echo "0 5 * * 0 reboot" | tee -a /etc/crontabs/root;
echo "ip6tables -t mangle -I POSTROUTING -o wwan0 -j HL --hl-set 64" | tee -a /etc/firewall.user;
echo "ip6tables -t mangle -I PREROUTING -i wwan0 -j HL --hl-set 64" | tee -a /etc/firewall.user;
echo "Check Response SMS ➜ AT+QMGDA=?;AT+QMGDA=?" | tee -a /etc/modem/atcommands.user;
echo "Delete all SMS ➜ AT+QMGDA;AT+QMGDA" | tee -a /etc/modem/atcommands.user;
echo "Check Response > AT+QMGDA=?;AT+QMGDA=?" | tee -a /etc/config/atcmds.user;
echo "Delete all SMS > AT+QMGDA;AT+QMGDA" | tee -a /etc/config/atcmds.user;
wget -q -O /usr/lib/ModemManager/connection.d/10-report-down "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_11dec_owrt/11dec-updatedmm";
wget -q -O /etc/rc.local "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_11dec_owrt/11dec-rc.local";
wget -q -O /etc/banner "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_11dec_owrt/11dec-banner";
wget -q -O /etc/config/shadowsocksr "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_11dec_owrt/11dec-ssrplus";
wget -q -O /etc/config/passwall "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_11dec_owrt/11dec-passwall";
reboot
