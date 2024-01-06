#! /bin/bash

#Description: Script to install some basic pakages Linux, This is compatible with Ubuntu, Alpine and CentOS Family
#Author: Chinwendu Eke
#Date: Nov 5th 2023

echo "Identifying Operating System"
DISTRO=$(. /etc/os-release && echo "$ID")
UBT='ubuntu'
COS='centos'
#RHEL='(Fedora)|(Red Hat.*)'
ALP='alpine'

if [[ "$DISTRO" == "$UBT" ]]
then
        echo "Ubuntu Detected"
	#Remove docker
	sudo apt-get install -y git vim net-tools sysstat zip wget curl

elif [[ "$DISTRO" =~ "$COS" ]]
then
        echo " OS: $DISTRO Detected"
	sudo yum install -y git vim net-tools sysstat zip wget curl
elif [[ "$DISTRO" =~ "$ALP" ]]
then
        echo " OS: $DISTRO Detected"
<<<<<<< HEAD
	sudo apk add -y git vim net-tools sysstat zip wget curl
=======
	sudo apk add git vim net-tools sysstat zip wget curl
>>>>>>> d7b6ca0d89db3ff27d9af030ae410ea50855b11b
else
        echo "Not compatible with operating system"
fi
