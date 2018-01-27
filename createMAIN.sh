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

cleanCFG=$(tail -n +36 createCFG.env | egrep -ic "VpcId|Pubnet|AvailabilityZone|PRVnet|iNETGW|RouterID")
[ $cleanCFG -gt 0 ] && { echo ERROR Config file is already populated ; exit ; }

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

# PRIVATE Subnet
 source ./createRDSnet1
# PRIVATE Subnet
 source ./createRDSnet2

#
 source ./createPEMKEY
#

# PUB EC2
source ./createPUBEC2-1          #
# PUB EC2
source ./createPUBEC2-2          #

# Machine Learning Server
source ./createPUBEC2-2          #

exit 0;

# identity and Portal option

# Create S3 Buckets
 aws s3api create-bucket --bucket processminer-${MajorTag}-archive --region ${myREGION}
 aws s3api create-bucket --bucket processminer-${MajorTag}-lambda --region ${myREGION}
 aws s3api create-bucket --bucket processminer-${MajorTag}-cloudtrail --region ${myREGION}
 aws s3api create-bucket --bucket processminer-${MajorTag}-albwaf --region ${myREGION}
 aws s3api create-bucket --bucket processminer-${MajorTag}-logging --region ${myREGION}

 # aws s3api delete-bucket --bucket processminer-${MajorTag}-archive --region ${myREGION}
 # aws s3api delete-bucket --bucket processminer-${MajorTag}-lambda --region ${myREGION}
 # aws s3api delete-bucket --bucket processminer-${MajorTag}-cloudtrail2 --region ${myREGION}
 # aws s3api delete-bucket --bucket processminer-${MajorTag}-albwaf --region ${myREGION}
 # aws s3api delete-bucket --bucket processminer-${MajorTag}-logging --region ${myREGION}

exit 0;

#### Above are tested, Below are not

# PUB RDS with MYSQL
# source ./createRDSapp

# API GW
# source ./createAPIGW

# DYNAMODB
# source ./createDYNADB

# Cloudwatchmetrics scripts

# alb
# albwaf

exit 0;
