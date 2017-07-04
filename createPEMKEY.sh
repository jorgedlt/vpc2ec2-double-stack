#!/usr/bin/env bash

#
# Create VPC, InternetGatewayId, Public & Private subnets with EC2
#

# jorgedlt@gmail.com - 03 MAR 2017 / 02 JUL 2017
# additional private documentation
# see - https://docs.google.com/document/d/1RdN2hbPeSvrCDTa76iZyExmVhF-Ct9iv-TcFNMRZwSU/edit

# Load ENV parameters
source ./createCFG.env

echo "Create Key Pair"

#debug block
  ./showENV.sh
#

export myACCOUNT=$(aws iam list-account-aliases | tr -d '{|}|[|]|"| |-' | egrep -v ':|^$');
export myREGION=$(aws configure list | grep region | awk '{print $2}' | tr -d '{|}|[|]|"| |-' );

# create-key-pairs
aws ec2 create-key-pair \
 --region ${AWS_DEFAULT_REGION} \
 --key-name "${myACCOUNT}-${myREGION}-${VpcId}" \
 | jq -r ".KeyMaterial" > ./${myACCOUNT}-${myREGION}-${VpcId}.pem

#  | grep KeyMaterial | cut -d':' -f2 | tr -d ',|"| |')
# echo -e ${MyKEY} > ${myACCOUNT}-${myREGION}-${VpcId}.pem

# update creatCFG file
echo "export EC2_keyname=${myACCOUNT}-${myREGION}-${VpcId}" >> ${build_CFG}

#
# aws ec2 describe-key-pairs
# aws ec2 delete-key-pair --key-name
#