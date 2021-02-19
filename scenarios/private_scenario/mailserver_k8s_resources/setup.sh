#!/bin/bash
#
# creates 'mailserver' namespace and setups other requirements as specified in the docs:
#   'https://github.com/technicalguru/docker-mailserver/tree/master/examples/kubernetes'
#

MAILSERVER_NODE=node2

echo "chosen node ($MAILSERVER_NODE)"
echo "configure this node's IP in the postfix service file !!!"

kubectl create namespace mailserver

kubectl label node $MAILSERVER_NODE mailserver/environment=mailserver
