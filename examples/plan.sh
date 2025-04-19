#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

#read a flag for environment
while getopts ":e:" opt; do
  case $opt in
    e) environment=$OPTARG ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
    :)  echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
  esac
done

#check if environment is set
if [ -z "$environment:-" ]; then
  echo "Environment is not set. Please set it using -e flag."
  exit 1
fi

#check if environment is valid
if [[ ! "$environment" =~ ^(dev|staging|prod)$ ]]; then
  echo "Invalid environment. Please set it to dev, staging or prod."
  exit 1
fi

#run terraform init with backend config
terraform plan -var-file="${environment}/${environment}.tfvars"   
