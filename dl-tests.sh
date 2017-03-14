#!/bin/bash

tag=v2.9.0

set -e

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
    set +e
    [ -z "$tmp" -o ! -d "$tmp" ] || rm -rf "$tmp"
}

unset CDPATH
pwd=$(pwd)

pushd "$tmp"
git clone git://github.com/visionmedia/commander.js.git
cd commander.js
git archive --prefix="test/" --format=tar tags/${tag}:test/ \
    | bzip2 > "$pwd"/tests-${tag}.tar.bz2
git archive --prefix="examples/" --format=tar tags/${tag}:examples/ \
    | bzip2 > "$pwd"/examples-${tag}.tar.bz2
popd
