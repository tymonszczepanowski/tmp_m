#!/bin/env bash
set -xe
set -o pipefail

if [[ "$1" == "routes" || "$1" == "r" ]]; then
    SVC=service-ricplt-rtmgr-http
    NS=ricplt
    ENDPOINT="/ric/v1/getdebuginfo"
    echo "Get routes, IP: ${IP}, PORT: {3800}, ENDPOINT: ${ENDPOINT}"
elif [[ "$1" == "xapps" || "$1" == "x" ]]; then
    SVC=service-ricplt-appmgr-http
    NS=ricplt
    ENDPOINT="/ric/v1/xapps"
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

curl "http://${IP}:${PORT}${ENDPOINT}" | jq .
