#!/bin/bash

#Created by weslley, 31/05/2015
#Script to install zabbix agent


#check the OS version

echo "Checking O.S Version"
OSVERSION=$(cat /etc/redhat-release | cut -d " " -f 3 | tr -d '\.')


## Download and install the agent ##

	if [ "$OSVERSION" -eq 60 ] || [ "$OSVERSION" -gt 60 ] 
			then
			echo "Installing Zabbix REPO ..."
			rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
			echo "Installing Zabbix Agent....."
			yum install zabbix-agent

		elif [ [ "$OSVERSION" -eq 50 ] || [ "$OSVERSION" -gt 50 ] && [ "$OSVERSION" -gt 60 ] ]
			then
			echo "Installing Zabbix REPO ..."
			rpm -ivh http://repo.zabbix.com/zabbix/2.2/rhel/5/x86_64/zabbix-release-2.2-1.el5.noarch.rpm
			echo "Installing Zabbix Agent....."
			yum install zabbix-agent

		else 
			echo "Sistema nao suportado"
	fi


#Creating Mysql Zabbix USER

read -p "Enter Mysql Root PASS: " MYRPASS
echo "Creating Mysql Zabbix USER..."
mysql -uroot -p'$MYRPASS' -e "CREATE USER 'zabbixmonitor'@'localhost' IDENTIFIED BY 'vp+-45XW';"
mysql -uroot -p'$MYRPASS' -e "GRANT ALL PRIVILEGES ON *.* TO 'zabbixmonitor'@'localhost';"
mysql -uroot -p'$MYRPASS' -e "FLUSH PRIVILEGES;"



#Including Zabbix IP on CSF 

echo "Including Zabbix IP on CSF..."
csf -a 104.154.88.225


#Restarting services

echo "Restarting Zabbix-agent service..."
service zabbix-agent restart


