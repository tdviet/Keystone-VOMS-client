#!/bin/bash

# Viet Tran
# Institute of Informatcis SAS
# Oct 2015

# Change KEYSTONE and VO to your site if needed
export KEYSTONE="https://keystone3.ui.savba.sk:5000/v2.0/"
export CA="/etc/grid-security/certificates/SlovakGrid.pem"
export VO="fedcloud.egi.eu"

# Check if VOMS proxy is valid, otherwise request new one
voms-proxy-info -e ||  voms-proxy-init --voms $VO -rfc

# Get full token from Keystone
python ./keystone-voms.py

