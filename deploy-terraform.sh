#!/bin/bash

cd ./terraform

terraform init

terraform plan -var-file="devl.tfvars"

terraform apply -var-file="devl.tfvars"