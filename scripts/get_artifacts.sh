#!/bin/bash
set -eou pipefail
# 
# This script is used to fetch github release assets and write them out to a tmp path to upload to other destinations
#

log() {
  echo "--> $1"
}


TMPPATH=/tmp/files
if [ -z $1 ]; then
  log "must supply release url"
  exit 1
fi

log "creating tmp file path"
mkdir $TMPPATH
for i in  $(curl -s "${1}" |jq -r '.[].browser_download_url')
do
  log "downloading ${i} to ${TMPPATH}"
  (cd $TMPPATH && curl -O -s -L $i)
done
