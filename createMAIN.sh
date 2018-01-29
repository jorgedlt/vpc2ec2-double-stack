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

# previosly set to +36, but adding the i<cidr> info moved it down
cleanCFG=$(tail -n +72 createCFG.env | egrep -ic "VpcId|Pubnet|AvailabilityZone|PRVnet|iNETGW|RouterID")
[ $cleanCFG -gt 0 ] && { echo ERROR Config file is already populated ; exit ; }

# app VPC
 source ./createVPC
# PUBLIC Subnet
 source ./createPUBnet1
# app PUBLIC Subnet
 source ./createPUBnet2
# app PRIVATE Subnet
 source ./createPRVnet1
# app PRIVATE Subnet
 source ./createPRVnet2
# app Internet Gateway
 source ./createIGW
# app Security Groups
 source ./createSecGrp
# app PEM pair
 source ./createPEMKEY

# PRIVATE Subnet
 source ./createRDSnet1
# PRIVATE Subnet
 source ./createRDSnet2

# PUB EC2 -- For Main Site App 1
source ./createPUBEC2-1          #
# PUB EC2 -- For Main Site App 2
source ./createPUBEC2-2          #

# Machine Learning Server
source ./createPUBEC2-ml         #

# RDS Bastion Server
source ./createPUBEC2-bastion    #

# identity and Portal option

# Create S3 Buckets
 # aws s3api create-bucket --bucket processminer-${MajorTag}-archive --region ${myREGION}
 # aws s3api create-bucket --bucket processminer-${MajorTag}-lambda --region ${myREGION}
 # aws s3api create-bucket --bucket processminer-${MajorTag}-cloudtrail --region ${myREGION}
 # aws s3api create-bucket --bucket processminer-${MajorTag}-albwaf --region ${myREGION}
 # aws s3api create-bucket --bucket processminer-${MajorTag}-logging --region ${myREGION}

 # aws s3api delete-bucket --bucket processminer-${MajorTag}-archive --region ${myREGION}
 # aws s3api delete-bucket --bucket processminer-${MajorTag}-lambda --region ${myREGION}
 # aws s3api delete-bucket --bucket processminer-${MajorTag}-cloudtrail2 --region ${myREGION}
 # aws s3api delete-bucket --bucket processminer-${MajorTag}-albwaf --region ${myREGION}
 # aws s3api delete-bucket --bucket processminer-${MajorTag}-logging --region ${myREGION}

# APP RDS with MYSQL -- Leave this for last, as it takes logner to run
source ./createRDSapp

exit 0;

# API GW  (30% Complete) -- need schema from Manan
# source ./createAPIGW

# DYNAMODB (30% Complete) -- need schema from Manan
# source ./createDYNADB
# https://stackoverflow.com/questions/42435407/create-dynamodb-table-using-aws-cli

# # Cloudwatchmetrics scripts (80% Complete)
# # https://docs.aws.amazon.com/cli/latest/reference/cloudformation/create-stack.html
#
# # To create an AWS CloudFormation stack
# aws cloudformation create-stack \
#   --stack-name myteststack \
#   --template-body file://sampletemplate.json \
#   --parameters ParameterKey=KeyPairName,ParameterValue=TestKey ParameterKey=SubnetIDs,ParameterValue=SubnetID1\\,SubnetID2

# alb (80% Complete)
# https://docs.google.com/document/d/13fI_UCX7BJxNVSgIunlMUmmqtE5GvS_FWVLkbhWAOsw/edit

# albwaf (80% Complete)
# similar to Cloudwatchmetrics

exit 0;
