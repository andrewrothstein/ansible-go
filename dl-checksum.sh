#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://storage.googleapis.com/golang

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local suffix=$4
    local platform="${os}-${arch}"
    local file=go$ver.$platform.$suffix
    local dlfile=$DIR/$file
    local url=$MIRROR/$file
    if [ ! -e $dlfile ]
    then
        curl -sSLf -o $dlfile $url
    fi
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `sha256sum $dlfile | awk '{print $1}'`
}

dl_ver ()
{
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver darwin amd64 tar.gz
    dl $ver darwin arm64 tar.gz
    dl $ver freebsd 386 tar.gz
    dl $ver freebsd amd64 tar.gz
    dl $ver linux 386 tar.gz
    dl $ver linux amd64 tar.gz
    dl $ver linux armv6l tar.gz
    dl $ver linux arm64 tar.gz
    dl $ver linux ppc64le tar.gz
    dl $ver linux s390x tar.gz
    dl $ver windows 386 zip
    dl $ver windows amd64 zip
    dl $ver windows arm64 zip
}

dl_ver ${1:-1.22.4}
