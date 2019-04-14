#!/bin/bash -e

BASEDIR=$(dirname $0)

for FILE in $BASEDIR/*.md; do
	BASENAME=$(basename $FILE)
	OUTNAME=${BASENAME%.md}.html
	echo "$BASENAME -> $OUTNAME"
	TEMP=$(tempfile --dir=$BASEDIR)
	markdown $FILE > $TEMP
	mv $TEMP $BASEDIR/../$OUTNAME
done
