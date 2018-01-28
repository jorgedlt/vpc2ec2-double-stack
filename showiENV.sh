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
 echo "${CYAN}  MajoriTag           :${WHITE} ${MajoriTag}"
 echo "${CYAN}  MinoriTag           :${WHITE} ${MinoriTag}"
 echo
 echo "${CYAN}  build_CFG file     :${GREEN} ${build_CFG}"
 echo "${CYAN}  VPCiid              :${YELLOW} ${VpciId}"
 echo "${CYAN}  VPC_stack          :${YELLOW} ${VPC_stack}"
 echo "${CYAN}  EC2_stack          :${YELLOW} ${EC2_stack}"
 echo
 echo "${CYAN}  iNETGW             :${YELLOW} ${iNETGW}"
 echo "${CYAN}  RouterID           :${YELLOW} ${RouterID}"
 echo
 echo "${CYAN}  PUB1icidr            :${GREEN} ${PUB1cidr}"
 echo "${CYAN}  PRV1icidr            :${GREEN} ${PRV1cidr}"
 echo
 echo "${CYAN}  PUB2icidr            :${GREEN} ${PUB2cidr}"
 echo "${CYAN}  PRV2icidr            :${GREEN} ${PRV2cidr}"
 echo
 echo "${CYAN}  iAZone1              :${YELLOW} ${iAZone1}"
 echo "${CYAN}  iAZone2              :${YELLOW} ${iAZone2}"
 echo
 echo "${CYAN}  PUBinet1             :${YELLOW} ${PUBinet1}"
 echo "${CYAN}  PRVinet1             :${YELLOW} ${PRVinet1}"
 echo "${CYAN}  RDSinet1             :${YELLOW} ${RDiSnet1}"
 echo
 echo "${CYAN}  RDS1iazone           :${YELLOW} ${RDS1iazone}"
 echo "${CYAN}  RDS2iazone           :${YELLOW} ${RDS2iazone}"
 echo
 echo "${CYAN}  PUBinet2             :${YELLOW} ${PUBinet2}"
 echo "${CYAN}  PRVinet2             :${YELLOW} ${PRVinet2}"
 echo "${CYAN}  RDSinet2             :${YELLOW} ${RDSinet2}"
 echo
 echo "${CYAN}  AWS_DEFAULT_REGION :${GREEN} ${AWS_DEFAULT_REGION}"
 echo
 echo "${CYAN}  SGssh              :${YELLOW} ${SGssh}"
 echo "${CYAN}  EC2i_ami            :${GREEN} ${EC2i_ami}"
 echo "${CYAN}  EC2itype           :${GREEN} ${EC2i_type}"
 echo "${CYAN}  EC2i_keyname        :${YELLOW} ${EC2i_keyname}"
#
echo ${RESET}
