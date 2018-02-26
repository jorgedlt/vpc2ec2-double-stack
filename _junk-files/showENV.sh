#!/usr/bin/env bash

# Load ENV parameters
source ./createCFG.env

# debug block
echo
#
export myACCOUNT=$(aws iam list-account-aliases | tr -d '{|}|[|]|"| |-' | egrep -v ':|^$');
export myREGION=$(aws configure list | grep region | awk '{print $2}' | tr -d '{|}|[|]|"| |-' );
#
 echo "${CYAN}  ACCNTID            :${WHITE} ${myACCNTID}"
 echo "${CYAN}  ACCOUNT            :${WHITE} ${myACCOUNT}"
 echo "${CYAN}  REGION             :${WHITE} ${myREGION}"
 echo
 echo "${CYAN}  MajorTag           :${WHITE} ${MajorTag}"
 echo "${CYAN}  MinorTag           :${WHITE} ${MinorTag}"
 echo
 echo "${CYAN}  build_CFG file     :${GREEN} ${build_CFG}"
 echo "${CYAN}  VPCid              :${YELLOW} ${VpcId}"
 echo "${CYAN}  VPC_stack          :${YELLOW} ${VPC_stack}"
 echo "${CYAN}  EC2_stack          :${YELLOW} ${EC2_stack}"
 echo
 echo "${CYAN}  iNETGW             :${YELLOW} ${iNETGW}"
 echo "${CYAN}  RouterID           :${YELLOW} ${RouterID}"
 echo
 echo "${CYAN}  PUB1cidr            :${GREEN} ${PUB1cidr}"
 echo "${CYAN}  PRV1cidr            :${GREEN} ${PRV1cidr}"
 echo
 echo "${CYAN}  PUB2cidr            :${GREEN} ${PUB2cidr}"
 echo "${CYAN}  PRV2cidr            :${GREEN} ${PRV2cidr}"
 echo
 echo "${CYAN}  AZone1              :${YELLOW} ${AZone1}"
 echo "${CYAN}  AZone2              :${YELLOW} ${AZone2}"
 echo
 echo "${CYAN}  PUBnet1             :${YELLOW} ${PUBnet1}"
 echo "${CYAN}  PRVnet1             :${YELLOW} ${PRVnet1}"
 echo "${CYAN}  RDSnet1             :${YELLOW} ${RDSnet1}"
 echo
 echo "${CYAN}  RDS1azone           :${YELLOW} ${RDS1azone}"
 echo "${CYAN}  RDS2azone           :${YELLOW} ${RDS2azone}"
 echo
 echo "${CYAN}  PUBnet2             :${YELLOW} ${PUBnet2}"
 echo "${CYAN}  PRVnet2             :${YELLOW} ${PRVnet2}"
 echo "${CYAN}  RDSnet2             :${YELLOW} ${RDSnet2}"
 echo
 echo "${CYAN}  AWS_DEFAULT_REGION :${GREEN} ${AWS_DEFAULT_REGION}"
 echo
 echo "${CYAN}  SGssh              :${YELLOW} ${SGssh}"
 echo "${CYAN}  EC2_ami            :${GREEN} ${EC2_ami}"
 echo "${CYAN}  EC2_type           :${GREEN} ${EC2_type}"
 echo "${CYAN}  EC2_keyname        :${YELLOW} ${EC2_keyname}"
#
echo ${RESET}
