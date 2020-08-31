#!/usr/bin/env bash

NAMESPACE="$1"
REGION="$2"
KP_INSTANCE_ID="$3"

kubectl delete secret -n "${NAMESPACE}" key-protect-access
