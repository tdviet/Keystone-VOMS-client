#!/bin/bash

# Viet Tran
# Institute of Informatcis SAS
# Oct 2015

# Change KEYSTONE and VO to your site if needed
KEYSTONE="https://keystone3.ui.savba.sk:5000/v2.0/"
CA_PATH="/etc/grid-security/certificates/"
VO="fedcloud.egi.eu"

# Check if VOMS proxy is valid, otherwise request new one
voms-proxy-info -e ||  voms-proxy-init --voms $VO -rfc

# Get full token from Keystone
token=$(curl -s -f --capath $CA_PATH --cert $X509_USER_PROXY -d '{"auth":{"voms": true}}' \
        -H "Content-type:application/json" $KEYSTONE/tokens)

if [ $? -eq 0 ]
then
  # Success, parsing the full token and print just token ID
  echo -n "The generated keystone token is: "
  echo $token | python -c 'import sys, json; print json.load(sys.stdin)["access"]["token"]["id"]'
else
  # Error, print debug info and exit
  echo "Error while getting token. Please execute the following command to see full error message:"
  echo curl -v --capath $CA_PATH --cert $X509_USER_PROXY -d '{"auth":{"voms": true}}' -H "Content-type:application/json" $KEYSTONE/tokens
fi


