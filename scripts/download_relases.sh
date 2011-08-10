#!/usr/bin/env bash

curl -s http://nginx.org/en/CHANGES     |\
grep "Changes with nginx"               |\
awk '{print $4}'                        |\
while read release
do
    echo
    echo "Downloading release: $release"
    wget -c -N http://sysoev.ru/nginx/nginx-$release.tar.gz
done

to_major=1
for major in $(seq 0 $to_major)
do
    to_minor=1
    to_revision=10
    if [[ $major == 0 ]]
    then
        to_minor=9
        to_revision=99
    elif [[ $major == 1 ]]
    then
        to_minor=1
        to_revision=99
    fi
    for minor in $(seq 0 $to_minor)
    do
        for revision in $(seq 0 $to_revision)
        do
            release="$major.$minor.$revision"
            echo
            echo "Downloading release: $release"
            wget -c -N http://sysoev.ru/nginx/nginx-$release.tar.gz
        done
    done
done
