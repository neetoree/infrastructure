#!/usr/bin/env bash
set -e

memberenv=$1

[ ! $memberenv ] && exit

set -a
. assets/cluster.env
. $memberenv
set +a

[ -e keys/$member_host.pem ] && exit

bin/cfssl gencert -ca=keys/ca.pem -ca-key=keys/ca-key.pem -profile server -config assets/config.json <(envsubst < assets/member.json) | bin/cfssljson -bare keys/$member_host
