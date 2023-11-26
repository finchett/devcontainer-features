#!/usr/bin/env bash

set -e

ARCHITECTURE=${ARCHITECTURE:-"x86_64"}
VERSION=${VERSION:-"latest"}

apt_get_update_if_needed() {
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update
    else
        echo "Skipping apt-get update."
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    for pkg in "$@"; do
        if ! dpkg -s "$pkg" > /dev/null 2>&1; then
            apt_get_update_if_needed
            apt-get -y install --no-install-recommends "$pkg"
        fi
    done
}

install_from_github_releases() {
    if [ "${ARCHITECTURE}" = "x86_64" ]; then
        archStr="amd64"
    elif [ "${ARCHITECTURE}" = "arm64" ]; then
        archStr="arm64"
    fi

    if [ "${VERSION}" = "latest" ]; then
        releaseUrlSuffix=$VERSION
    else
        releaseUrlSuffix="tags/v${VERSION}"
    fi

    influxDir="/tmp/influxCLI"

    rm -rf /tmp/influxCLI/
    mkdir "$influxDir"
    
    releasePage=$(wget -q -O - "https://api.github.com/repos/influxdata/influx-cli/releases/${releaseUrlSuffix}")
    downloadUrl=$(echo $releasePage | jq -r ".body | select(contains(\"${archStr}\"))" | egrep -o "https?://[^ ]+linux-${archStr}.tar.gz")
    
    wget $downloadUrl -P $influxDir

    tar xvzf "$(find "$influxDir" -name '*influxdb2-client*')" -C "$influxDir"
    cp "${influxDir}/influx" "/usr/local/bin/influx"
    rm -rf "$influxDir"
}

check_packages wget jq ca-certificates
install_from_github_releases
