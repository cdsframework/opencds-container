#!/bin/sh
##
#  Utility script to aid in the initialization of a local minikube environment,
#  for the benefit of RCKMS development staff who are not accustomed to
#  running orchastrated clusters, and those who want to not waste time
#  screwing around in kubectl.
#
#  This script is specific to initializing the opencds component.
#
##

echo
echo ">> HLN::RCKMS >> 🐳  Building and tagging Docker Container for opencds-rckms..."
echo
docker image build -f opencds-container/Dockerfile -t opencds-rckms:$CURRENT_TS .
sleep 1
echo
echo ">> HLN::RCKMS >> 🛰️  Applying opencds-rckms manifest..."
echo
kubectl apply -f opencds-container/service.minikube.yaml
sleep 1
kubectl set image deployment opencds *=opencds-rckms:$CURRENT_TS

