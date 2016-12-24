#!/usr/bin/env bash
set -e

set -a
. assets/cluster.env
set +a

bin/cfssl gencert -initca <(envsubst < assets/ca.json) -config <(envsubst < assets/config.json) | bin/cfssljson -bare keys/ca
