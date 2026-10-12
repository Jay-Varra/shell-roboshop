#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-00f0f0b377e08aac3"
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z031556717KQVPN4GTNYL"
DOMAIN_NAME="robos.baby"

for instance in ${INSTANCES[@]}
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0220d79f3f480ecf5 --instance-type t2.micro --security-group-ids sg-00f0f0b377e08aac3 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=test}]" --query "Instances[0].InstanceId" --output text)
    if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 run-instances --image-id ami-0220d79f3f480ecf5 --instance-type t2.micro --security-group-ids sg-00f0f0b377e08aac3 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=test}]" --query "Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 run-instances --image-id ami-0220d79f3f480ecf5 --instance-type t2.micro --security-group-ids sg-00f0f0b377e08aac3 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=test}]" --query "Instances[0].PublicIpAddress" --output text)
    fi
    echo "$instance IP address is $IP"
done