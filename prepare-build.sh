#!/bin/sh

export DEBFULLNAME=${DEBFULLNAME:-FlightAware build automation}
export DEBEMAIL=${DEBEMAIL:-adsb-devs@flightaware.com}

TOP=$(dirname $0)
DIST=$1
OUT=$2

if [ -n "$OUT" ]
then
    OUT=$(realpath $OUT)
else
    OUT=$(realpath package-$DIST)
fi

cp -a $TOP/tcltls-1.7.22 $OUT
cd $OUT

case "$DIST" in
    buster)
        dch --local ~bpo10+ --distribution buster-backports --force-distribution "Automated backport to buster"
        ;;
    bullseye)
        dch --local ~bpo11+ --distribution bullseye-backports --force-distribution "Automated backport to bullseye"
        ;;
    bookworm)
        ;;
    *)
        echo "Don't know how to build tcltls for a distribution named $DIST" >&2
        exit 1
        ;;
esac
