#!/usr/bin/env bash

# Print latest Nginx release version and download URL.
#
# Author: Rogério Carvalho Schneider <stockrt@gmail.com>

LATEST=$(curl -s http://wiki.nginx.org/Install              |\
grep '<p><a href="http://nginx.org/download/nginx-'         |\
head -n 1                                                   |\
egrep -o 'http://nginx\.org/download/nginx-.*\.tar\.gz')

VERSION=$(echo "$LATEST"                                    |\
awk -F 'http://nginx.org/download/nginx-' '{print $2}'      |\
awk -F '.tar.gz' '{print $1}')

echo "Latest: $LATEST"
echo "Version: $VERSION"
