#!/bin/bash

#
#  ec2configs/public-ec2-build.sh - auto config and run for AWS/EC2 - vpc2ec2
#
#  jorgedlt@gmail.com - 02 JUL 2017 -
#

set -e -x
export DEBIAN_FRONTEND=noninteractive

# System Updates
apt update -y && sudo apt upgrade -y

# Install Prerequisites
apt-get install -y --no-install-recommends \
 automake \
 libcurl4-openssl-dev \
 htop \
 ntp \
 git \
 make \
 gcc \
 libc6-dev ca-certificates

# Automatically installing Oracle JAVA on UBUNTU
  apt-get install -y python-software-properties debconf-utils
  add-apt-repository -y ppa:webupd8team/java
  apt-get update
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" |  debconf-set-selections
  apt-get install -y oracle-java8-installer

#
systemctl restart ntp

# Divine the Account ID last-4 from meta-data
AWSenv=$( curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep accountId | cut -d':' -f2 | tr -d ' |"|,' | cut -c9- )

# Generate a Rnadom WorkerID
sleep 5
    workedID=$( echo {0..9}{0..9}{0..9}{0..9} | tr ' ' '\012' | shuf | head -1 )
sleep 5
#
curl -O https://www.loggly.com/install/configure-file-monitoring.sh
echo CmJbFxmTWyHrvUwob9qdopo3 | sudo bash configure-file-monitoring.sh -a jdelatorre -t a4266c53-c626-4201-bb5f-98323801ea29 -u jorgedlt -f /var/log/syslog -l Miner-${AWSenv}-java-${workedID}
