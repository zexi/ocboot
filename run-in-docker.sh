#!/bin/bash

REGISTRY=${REGISTRY:-registry.cn-beijing.aliyuncs.com/yunionio}
VERSION=${VERSION:-v3.10.6}
OCBOOT_IMAGE="$REGISTRY/ocboot:$VERSION"

if ! docker ps > /dev/null; then
    echo 'Error: execute `docker ps` error'
    exit 1
fi

ENTRYPOINT='/opt/ocboot/run.py'

if [ $# -eq 0 ]; then
    docker run --rm $OCBOOT_IMAGE -h
    exit 1
fi

run_cmd="docker run --rm -t --network host"

$run_cmd -v "$HOME/.ssh:/root/.ssh:ro" -v "$(pwd)":/opt/ocboot:rw --entrypoint $ENTRYPOINT $OCBOOT_IMAGE $@
