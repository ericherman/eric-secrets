#!/bin/bash

#TODO consider getopts

if [ "_${1}_" == "__" ]; then
	echo "must specify a file name"
        exit 1
fi
INFILE=$1

if [ "_${2}_" == "__" ]; then
    GUSER=$(grep 'email[ ]*=' ~/.gitconfig | cut -f2 -d '=' | sed 's/^[ ]*//g')
else
    GUSER="${2}"
fi

OUTDIR=gpg
TIMESTAMP=$(date --utc +"%Y%m%dT%H%M%SZ")
OUTFILE=$OUTDIR/$(basename $INFILE).${TIMESTAMP}.gpg

gpg \
 --armor \
 --recipient="$GUSER" \
 --encrypt $INFILE
mv -v ${INFILE}.asc ${OUTFILE}
