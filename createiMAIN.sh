#!/usr/bin/env bash

#
# Create VPC, InternetGatewayId, Public & Private subnets with EC2
# As New Install and Disaster Recovery for Process Miner

# Load ENV parameters
# source ./createCFG.env     # each createFILE in turn calls this

unset cleanCFG

# add something here to halt script if in wrong Account and/or Region
# add something here to halt script if in wrong Account and/or Region
export myACCOUNT=$(aws iam list-account-aliases | tr -d '{|}|[|]|"| |-' | egrep -v ':|^$');
export myREGION=$(aws configure list | grep region | awk '{print $2}' | tr -d '{|}|[|]|"| |-' );

source ./createCFG.env

echo $myACCOUNT $AWSaccount
[[ "$myACCOUNT" -eq "$AWSaccount" ]] && { : ; } || { echo ERROR Account MisMatch ; exit ; }

# cleanCFG=$(tail -n +36 createCFG.env | egrep -ic "VpcId|Pubnet|AvailabilityZone|PRVnet|iNETGW|RouterID")
# [ $cleanCFG -gt 0 ] && { echo ERROR Config file is already populated ; exit ; }

# VPC
 source ./createiVPC
# PUBLIC Subnet
 source ./createiPUBnet1
# PUBLIC Subnet
 source ./createiPUBnet2
# PRIVATE Subnet
 source ./createiPRVnet1
# PRIVATE Subnet
 source ./createiPRVnet2
# Internet Gateway
 source ./createiIGW
# Security Groups
 source ./createiSecGrp
# PEM pair

# PRIVATE Subnet
 source ./createiRDSnet1
# PRIVATE Subnet
 source ./createiRDSnet2

#
 source ./createiPEMKEY
#

# PORTAL EC2
source ./createPORTALec2-1         #
#        EC2
source ./createPORTALec2-2         #

# IDENTITY EC2
source ./createIDENTITYec2-1       #
#        EC2
source ./createIDENTITYec2-2       #

# APP RDS with MYSQL -- Leave this for last, as it takes logner to run
source ./createRDSidp

exit 0;


exit 0;
