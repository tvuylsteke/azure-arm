# Executed with the script extension in the ARM template
yum -y install epel-release
yum -y install nginx
systemctl start nginx
systemctl enable nginx
cp /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.bak
echo $HOSTNAME > /usr/share/nginx/html/index.html

# only for the NVA
if [[ "$HOSTNAME" =~ .*nva.* ]]; then
    # enable IP Forwarding
    echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
    sysctl -p /etc/sysctl.conf
fi


# not necessary
#iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
#iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT

# ensure traffic comes from the same IP. Not needed for single interface NVA's
# this is not persistent
#route add -net 10.0.1.0 netmask 255.255.255.0 gw 10.0.4.1
#route add -net 10.0.2.0 netmask 255.255.255.0 gw 10.0.3.1

# ensure traffic comes from the same IP. Not needed for single interface NVA's
# this is persistent
# https://www.systutorials.com/qa/308/where-are-the-linux-routing-table-entries-stored-on-disk
#echo "any net 10.0.1.0 netmask 255.255.255.0 gw 10.0.4.1" >> /etc/sysconfig/static-routes
#echo "any net 10.0.2.0 netmask 255.255.255.0 gw 10.0.3.1" >> /etc/sysconfig/static-routes
#/etc/init.d/network restart

# usefull commands
#
# tcpdump icmp
# tcpdump icmp -nni eth1
# tcpdump -s0 host 10.0.2.4 and port 80 -q
# curl http://10.0.2.4