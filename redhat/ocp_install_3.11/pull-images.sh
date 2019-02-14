#!/usr/bin/env bash

set -e
set -x

dummy=$1

# mkdir -p tmp

source config.sh

while read -r line; do
    if [[ "$line" =~ [^[:space:]] ]]; then
        # read -ra images <<<"$line"
        # echo "docker save ${images[0]} | gzip -c > tmp/${images[1]}"
        # if [ "$dummy" != "dummy" ]; then
        #     docker save ${images[0]} | gzip -c > tmp/${images[1]}
        # fi
        docker pull $line;
    fi
done <<< "$ose3_images"

cmd_str="docker save -o ose3-images.tar "
while read -r line; do
    if [[ "$line" =~ [^[:space:]] ]]; then
        # read -ra images <<<"$line"
        # echo "docker save ${images[0]} | gzip -c > tmp/${images[1]}"
        # if [ "$dummy" != "dummy" ]; then
        #     docker save ${images[0]} | gzip -c > tmp/${images[1]}
        # fi
        cmd_str+=" $line"
    fi
done <<< "$ose3_images"

$($cmd_str)

docker image prune -f



