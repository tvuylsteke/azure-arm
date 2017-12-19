# {"fileUris":["https://mystorage.blob.core.windows.net/scripts/install_lamp.sh"], "commandToExecute":"sh install_lamp.sh" }

#sudo -i
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

# not necessary
#iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
#iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT

# ensure traffic comes from the same IP. Not needed for single interface NVA's
# this is not persistent
#route add -net 10.0.1.0 netmask 255.255.255.0 gw 10.0.4.1
#route add -net 10.0.2.0 netmask 255.255.255.0 gw 10.0.3.1

# https://www.systutorials.com/qa/308/where-are-the-linux-routing-table-entries-stored-on-disk
echo "any net 10.0.1.0 netmask 255.255.255.0 gw 10.0.4.1" >> /etc/sysconfig/static-routes
echo "any net 10.0.2.0 netmask 255.255.255.0 gw 10.0.3.1" >> /etc/sysconfig/static-routes
/etc/init.d/network restart

#reboot
#Tcpdump icmp
#Tcpdump icmp -nni eth1