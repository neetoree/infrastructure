#!/usr/bin/env bash
set -e

memberenv=$1

[ ! $memberenv ] && exit

set -a
. assets/cluster.env
. $memberenv
set +a

gzb64() {
    cat $1 | gzip | base64 -w0
}

export cluster_path=$(echo $cluster_domain | tr '.' '\n' | tac | tr '\n' '/' | sed 's|/$||g')

export cluster_etcdhosts=$(find members -type f | xargs -I {} bash -c '. {}; echo -n $member_host=http://$member_ip:2380,' | sed 's/,$//g')
export cluster_ca=$(gzb64 keys/ca.pem)
export member_cert=$(gzb64 keys/$member_host.pem)
export member_key=$(gzb64 keys/$member_host-key.pem)

envsubst < assets/cloud-config.yaml > configs/$member_ip.yaml

