#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status
#set -u # Treat unset variables as an error when substituting
#set -x # Print each command before executing it

#check if terraform is installed
if ! command -v terraform &> /dev/null
then
    echo "Terraform could not be found. Please install it first."
    exit
fi
#check if aws cli is installed
if ! command -v aws &> /dev/null
then
    echo "AWS CLI could not be found. Please install it first."
    exit
fi

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
terraform init -backend-config="dev/dev.config"
