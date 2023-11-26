#!/usr/bin/env bash

set -e

ARCHITECTURE=${ARCHITECTURE:-"x86_64"}
VERSION=${VERSION:-"latest"}

check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

install_from_github_releases() {

    if [ "${ARCHITECTURE}" == "x86_64" ]; then
        local archStr="amd64"
    elif [ "${ARCHITECTURE}" == "arm64" ]; then
        local archStr="arm64"
    fi

    if [ "${VERSION}" == "latest" ]; then
        local releaseUrlSuffix=$VERSION
    else
        local releaseUrlSuffix="tags/v${VERSION}"
    fi

    local influxDir=/tmp/influxCLI

    mkdir $influxDir
    wget $(wget -q -O - "https://api.github.com/repos/influxdata/influx-cli/releases/${releaseUrlSuffix}" |  jq -r ".body | select(contains(\"${archStr}\"))" | egrep -o "https?://[^ ]+linux-${archStr}.tar.gz") -P $influxDir
    tar xvzf $(find $influxDir -name '*influxdb2-client*') -C $influxDir
    sudo cp ${influxDir}/influx /usr/local/bin/influx
    rm -rf $influxDir
}

check_packages wget
install_from_github_releases

