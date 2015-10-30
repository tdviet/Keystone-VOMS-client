#!/bin/bash

KEYSTONE="https://keystone3.ui.savba.sk:5000/v2.0/"
VO="fedcloud.egi.eu"

voms-proxy-info -e ||  voms-proxy-init --voms $VO -rfc

echo -n "The generated keystone token is: "

curl -s --cert $X509_USER_PROXY -d '{"auth":{"voms": true}}' \
     -H "Content-type:application/json" $KEYSTONE/tokens | \
     python -c 'import sys, json; print json.load(sys.stdin)["access"]["token"]["id"]'

