#!/usr/bin/env sh
VER=1.12.9
DIR=~/Downloads
MIRROR=https://storage.googleapis.com/golang

dl()
{
    OS=$1
    PLATFORM=$2
    SUFFIX=$3
    FILE=go${VER}.$OS-$PLATFORM.$SUFFIX
    DLFILE=$DIR/$FILE
    URL=$MIRROR/$FILE
    if [ ! -e $DLFILE ]
    then
        wget -q -O $DLFILE $URL
    fi
    printf "    # %s\n" $URL
    printf "    %s-%s: sha256:%s\n" $OS $PLATFORM `sha256sum $DLFILE | awk '{print $1}'`
}

printf "  '%s':\n" $VER
dl darwin amd64 tar.gz
dl linux 386 tar.gz
dl linux amd64 tar.gz
dl linux armv6l tar.gz
dl linux arm64 tar.gz
dl windows 386 zip
dl windows amd64 zip


