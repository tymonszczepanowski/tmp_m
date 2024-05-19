#!/bin/env bash
set -eo pipefail

if [[ "$1" == "add" || "$1" == "a" ]]; then
    METHOD="POST"
    ENDPOINT="/ric/v1/handles/addrmrroute"
elif [[ "$1" == "delete" || "$1" == "d" ]]; then
    METHOD="DELETE"
    ENDPOINT="/ric/v1/handles/delrmrroute"
else
    echo "This script needs an argument. Possible arguments: [a]dd, [d]elete"
    return 1
fi

SVC="service-ricplt-rtmgr-http"
NS="ricplt"
IP=$(kubectl get svc $SVC -n $NS -o json \
    | jq .spec.clusterIP \
    | tr -d '"')
PORT=$(kubectl get svc $SVC -n $NS -o json \
    | jq .spec.ports[].port \
    | tr -d '"')

echo "Sending request to ${SVC} -> ${IP}:${PORT}${ENDPOINT}"
echo "xApp EndPoint: ${XAPP_ENDPOINT}"
curl -X "$METHOD" \
    "http://${IP}:${PORT}${ENDPOINT}" \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '[
    {
      "TargetEndPoint": service-ricxapp-scp-kpimon-rmr.ricxapp:4560,
      "MessageType: 12050,
      "SenderEndPoint": "",
      "SubscriptionID": 1
    }
    ]'
