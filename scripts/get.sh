#!/bin/env bash
set -eo pipefail

NS="ricplt"
if [[ "$1" == "routes" || "$1" == "r" ]]; then
    SVC=service-ricplt-rtmgr-http
    ENDPOINT="/ric/v1/getdebuginfo"
    echo "Get routes, IP: ${IP}, PORT: {3800}, ENDPOINT: ${ENDPOINT}"
elif [[ "$1" == "xapps" || "$1" == "x" ]]; then
    SVC=service-ricplt-appmgr-http
    ENDPOINT="/ric/v1/xapps"
elif [[ "$1" == "subscriptions" || "$1" == "s" ]]; then
    SVC=service-ricplt-submgr-http
    ENDPOINT="/ric/v1/subscriptions"
else
    echo "This script needs an argument. Possible arguments: [r]outes, [x]apps"
    return 1
fi

IP=$(kubectl get svc $SVC -n $NS -o json \
    | jq .spec.clusterIP \
    | tr -d '"')
PORT=$(kubectl get svc $SVC -n $NS -o json \
    | jq .spec.ports[].port \
    | tr -d '"')

echo "Sending request to ${SVC} at ${IP}:${PORT}${ENDPOINT}"
curl "http://${IP}:${PORT}${ENDPOINT}" | jq .
