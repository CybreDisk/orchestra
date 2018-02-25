#!/bin/sh
IFS=$'\n'
set -e

VERSION='0.0.0'

REPOSITORIES=`cat repositories`

if [ "x$PREFIX" == "x" ] ; then
	PREFIX="`pwd`/prefix"
fi

mkdir $PREFIX 2> /dev/null || true

echo "# CybreDisk Orchestra make.sh"
echo "version $VERSION"
echo "build started `date`"
echo "prefix is $PREFIX"

for i in $REPOSITORIES ; do
	if test "$i" == "${i#\#}" ; then
		echo "## `date`: $i"
		echo '```'
		pushd "$i"
		mkdir "$PREFIX/$i"
		make PREFIX="$PREFIX/$i"
		popd
		echo '```'
	fi
done

echo "build finished `date`"
