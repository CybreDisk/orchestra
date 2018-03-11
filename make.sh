#!/bin/sh
IFS=$'\n'
set -e

VERSION='0.2.1'

REPOSITORIES=`cat repositories`

if [ "x$PREFIX" == "x" ] ; then
	PREFIX="`pwd`/prefix"
	mkdir "$PREFIX" 2> /dev/null || true
fi

rm -r "$PREFIX" 2> /dev/null || true
mkdir "$PREFIX" 2> /dev/null || true

if [ ! -d "$PREFIX" ] ; then
	echo '$PREFIX must be an existing directory'
	exit 1
fi

if [ ! -z "`ls "$PREFIX"`" ] ; then
	echo '$PREFIX must be empty'
	exit 2
fi

if [ "x$PREBUILD" == "x" ] ; then
	PREBUILD="`pwd`/pre-build.sh"
fi

if [ "x$POSTBUILD" == "x" ] ; then
	POSTBUILD="`pwd`/post-build.sh"
fi

echo "# CybreDisk Orchestra make.sh"
echo "version $VERSION"
echo "build started `date`"
echo "prefix is $PREFIX"

echo "## `date`: running pre-build actions"
test -x "$PREBUILD" && "$PREBUILD" "$PREFIX" pre-build

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

echo "## `date`: running post-build actions"
test -x "$POSTBUILD" && "$POSTBUILD" "$PREFIX" post-build

echo "build finished `date`"
