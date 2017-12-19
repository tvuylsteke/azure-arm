#{"fileUris":["https://mystorage.blob.core.windows.net/scripts/install_lamp.sh"], "commandToExecute":"sh install_lamp.sh" }

sudo -i
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

# not necessary
#iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
#iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT

#ensure traffic comes from the same IP. Not needed for single interface NVA's
route add -net 10.0.1.0 netmask 255.255.255.0 gw 10.0.4.1
route add -net 10.0.2.0 netmask 255.255.255.0 gw 10.0.3.1

#reboot
#Tcpdump icmp
#Tcpdump icmp -nni eth1