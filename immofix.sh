sed -i '/irq/d' /etc/crontabs/root;
sed -i '/irq5/d' /etc/crontabs/root;
rm -r /etc/config/irq5;
rm -r /etc/hotplug.d/iface/99-irq4;
wget -q -O /etc/hotplug.d/iface/80-rirq "https://github.com/NevermoreSSH/openwrt-packages2/releases/download/arca_11dec_owrt/80-rirq";
echo -e "Success optimize settings . . .";
read -p "$( echo -e "Press Enter Back to menu . . .")";
clear;
cat /etc/banner
