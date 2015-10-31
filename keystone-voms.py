#!/usr/bin/python

# Viet Tran
# IISAS 2015


import requests
import json
import os


keystone = os.environ['KEYSTONE']+'/tokens'
ca = os.environ['CA']
proxy = os.environ['X509_USER_PROXY']

r = requests.post(keystone, verify=ca, cert=proxy, 
                  headers={"Content-type":"application/json"}, 
                  data=json.dumps({'auth':{'voms': True}}))

if (r.status_code != 200):
    print 'Error while getting token. The server return error message:'
    print r.text
else:
    print 'The token is: ' + r.json()['access']['token']['id']

