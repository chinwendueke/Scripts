#! /bin/bash

#Description: Script to install Docker on Linux, This is presently compatible with Ubuntu, Alpine and CentOS Family
#Author: Chinwendu Eke
#Date: Nov 5th 2023

echo "Identifying Operating System"
DISTRO=$(cat /etc/os-release | head -1 | awk -F= '{print $2}' | sed 's/"//g')
#DISTRO=$(. /etc/os-release && echo "$ID")
UBT='Ubuntu'
COS='CentOS Linux'
#RHEL='(Fedora)|(Red Hat.*)'
ALP='Alpine Linux'

if [[ "$DISTRO" == "$UBT" ]]
then
        echo "Ubuntu Detected"
	#Remove docker
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get update -y
	sudo apt-get install ca-certificates curl gnupg lsb-release -y
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
	      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update -y

	if [ $? -ne 0 ]]
	then
        	sudo chmod a+r /etc/apt/keyrings/docker.gpg
        	sudo apt-get update -y
	fi

	# Install docker
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

	#Test
	sudo docker run hello-world

elif [[ "$DISTRO" =~ "$COS" ]]
then
        echo " OS: $DISTRO Detected"
	sudo yum remove docker docker-client docker-client-latest docker-common \
                  docker-latest docker-latest-logrotate docker-logrotate \
                  docker-engine podman runc -y
	sudo yum install -y yum-utils
	sudo yum-config-manager \
		--add-repo \
		https://download.docker.com/linux/centos/docker-ce.repo
	sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
	sudo systemctl start docker
	sudo docker run hello-world
#elif [[ "$DISTRO" =~ "$RHEL" ]]
#then
#	echo "OS : $DISTRO Dectected"
#	sudo yum remove docker docker-client docker-client-latest docker-common \
#                  docker-latest docker-latest-logrotate docker-logrotate \
#                  docker-engine podman runc -y
#        sudo yum install -y yum-utils
#        sudo yum-config-manager \
#                --add-repo \
#                https://download.docker.com/linux/rhel/docker-ce.repo
#        sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
#        sudo systemctl start docker
#        sudo docker run hello-world
elif [[ "$DISTRO" =~ "$ALP" ]]
then
        echo " OS: $DISTRO Detected"
	sudo apk add docker
	sudo addgroup username docker
	sudo rc-update add docker boot
	sudo service docker start
	sudo apk add docker-compose
else
        echo "Not compatible with operating system"
fi
