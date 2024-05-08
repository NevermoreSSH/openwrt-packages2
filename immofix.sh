sed -i '/irq/d' /etc/crontabs/root;
sed -i '/irq5/d' /etc/crontabs/root;
rm -r /etc/config/irq5;
rm -r /etc/hotplug.d/iface/99-irq4;
cat <<'EOF' >>/etc/hotplug.d/iface/80-rirq

#!/bin/sh

log () {
	modlog "$@"
}

[ "$ACTION" = ifup -o "$ACTION" = ifupdate ] || exit 0
	sleep 10
	sh /etc/config/irq4
  logger "Reloading irqbalance when $INTERFACE ($DEVICE) is now up"
	fi
fi

EOF
sleep 1;
echo -e "Success . . .";
read -p "$( echo -e "Press Enter Back to menu . . .")";
clear;
cat /etc/banner