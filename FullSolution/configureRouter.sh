#{"fileUris":["https://mystorage.blob.core.windows.net/scripts/install_lamp.sh"], "commandToExecute":"sh install_lamp.sh" }


echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT
route add -net 10.0.1.0 netmask 255.255.255.0 gw 10.0.0.97
route add -net 10.0.3.0 netmask 255.255.255.0 gw 10.0.0.65
reboot