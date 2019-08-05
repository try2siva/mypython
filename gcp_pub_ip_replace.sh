#!/bin/bash
ip1=$(grep -i "test.local" /etc/hosts | awk '{print $1}')
ip2=`curl -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip > /tmp/current_dynamic_ip`
pub_ip=`cat /tmp/current_dynamic_ip`
if [ "$ip1" != "$pub_ip" ]; then
	echo $(`sed -i s/$ip1/$pub_ip/ /etc/hosts` echo "New Public GCP instance IP replaced")
else
	echo "Existing Public GCP instance IP and Current IP matching"
fi
