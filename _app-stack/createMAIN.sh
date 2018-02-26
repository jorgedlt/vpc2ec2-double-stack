#!/usr/bin/env bash

#
# Create VPC, InternetGatewayId, Public & Private subnets with EC2
# As New Install and Disaster Recovery for Process Miner

# Load ENV parameters
# source ./createCFG.env     # each createFILE in turn calls this

# add something here to halt script if in wrong Account and/or Region
export myACCOUNT=$(aws iam list-account-aliases | tr -d '{|}|[|]|"| |-' | egrep -v ':|^$');
export myREGION=$(aws configure list | grep region | awk '{print $2}' | tr -d '{|}|[|]|"| |-' );

source ./createCFG.env

echo $myACCOUNT $AWSaccount
[[ "$myACCOUNT" -eq "$AWSaccount" ]] && { : ; } || { echo ERROR Account MisMatch ; exit ; }

cleanCFG=$(tail -n +27 createCFG.env | egrep -ic "VpcId|Pubnet|AvailabilityZone|PRVnet|iNETGW|RouterID")
[ $cleanCFG -gt 0 ] && { echo ERROR Config file is already populated ; exit ; }

#
cfgregion=$(cat createCFG.env | grep AWSregion | cut -d'=' -f2 | cut -c7 | cut -d'=' -f2 | cut -c3-6)
cfgavzone=$(cat createCFG.env | grep AWSregion | cut -d'=' -f2 | cut -c7)
cfrhits=$(cat createCFG.env | grep zone | grep -c ${cfgregion})
cfzhits=$(cat createCFG.env | grep zone | grep -c ${cfgavzone})

echo ${cfrhits} ${cfzhits}
[[ ${cfrhits} = 0 ]] || [[ ${cfzhits} = 0 ]] && { echo config file mismatch on region; exit 1 ; }

# VPC
source ./createVPC

# PUBLIC Subnet
source ./createPUBnet1

# PUBLIC Subnet
source ./createPUBnet2

# PRIVATE Subnet
source ./createPRVnet1

# PRIVATE Subnet
source ./createPRVnet2

# Internet Gateway
source ./createIGW

# Security Groups
source ./createSecGrp

# PEM pair
source ./createPEMKEY

# PUB EC2
source ./createPUBEC2-1

# PUB EC2
source ./createPUBEC2-2

exit 0;

# PRV EC2
source ./createPRVEC2          # what makes the PRV different ?

# PUB EC2 with JAVA
# source ./createPUBJAVA

# PUB EC2 with MYSQL DB this will be PRIVATE once testing is complete
# source ./createPUBSQLDB

exit 0;

#### Above are tested, Below are not

# PUB EC2 with MYSQL
source ./createPUBSQL          # get MYSQL specs from Manan

# PUB RDS with MYSQL
source ./createPUBRDS

# API GW
source ./createAPIGW

# DYNAMODB
source ./createDYNADB

exit 0;
