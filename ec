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

if [ "_${3}_" == "__" ]; then
    OUTDIR=gpg
else
    OUTDIR="${3}"
fi
mkdir -pv "$OUTDIR"

TIMESTAMP=$(date --utc +"%Y%m%dT%H%M%SZ")
OUTFILE_BASE_NAME=$(basename "$INFILE" | sed -e's/[^A-Za-z0-9\.\-_]/_/g')
OUTFILE="$OUTDIR"/"${OUTFILE_BASE_NAME}.${TIMESTAMP}.gpg"

gpg \
 --verbose \
 --armor \
 --recipient="$GUSER" \
 --encrypt "$INFILE"

mv -v "${INFILE}.asc" "${OUTFILE}"
