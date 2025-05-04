#!/usr/bin/env bash

TARGETS="
x86_64-unknown-linux-gnu
x86_64-pc-windows-gnu
i686-pc-windows-gnu
i686-unknown-linux-gnu
"

docker build -t cross-rs-alpine:latest -f Dockerfile .

for target in $TARGETS; do
    echo "Compiling for $target..."
    cross build --target $target --release
done

docker images --format '{{json .Repository}} {{json .ID}}' | sed 's/"//gm' | rg 'cross-rs' | while read -r line; do
    data=($line);
    echo "Cleaning docker image ${data[0]} with ID ${data[1]}..."
    # docker rmi ${data[1]}
done
