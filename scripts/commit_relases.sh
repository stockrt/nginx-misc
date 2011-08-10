#!/usr/bin/env bash

commit () {
    release="$1"

    echo "Processing release: $release"
    (
        if [[ ! -f "nginx-$release.tar.gz" ]]
        then
            echo "Skipping release not found: $release"
            continue
        fi
        tar xzf nginx-$release.tar.gz -C build/         &&\
        rm -rf nginx-releases/*                         &&\
        cp -a build/nginx-$release/* nginx-releases/    &&\
        pushd nginx-releases/                           &&\
        git add .                                       &&\
        git ci -am "Release $release"                   &&\
        popd
    ) ||\
    (
        popd >/dev/null 2>&1
        echo "Error processing release: $release"
    )
}

mkdir build
mkdir nginx-releases
pushd nginx-releases
git init .
popd

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
            commit "$release"
        done
    done
done
