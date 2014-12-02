#!/bin/bash
CACHE_MANIFEST_FILE='./private/html5/base/cache.manifest' # Saves file to edit into variable

echo "CACHE MANIFEST
# 0.0.1.0.<%= CONFIG['manifest_version'] %>.4

#==================================================================.
# lists all resources that should be downloaded and stored locally |
#=================================================================='
CACHE:" > $CACHE_MANIFEST_FILE

RESOURCES_CONTENT=`find ./public -mindepth 3  -type f -not -path '*/\.*' | sed 's/.\/public//g' | tr ' ' '\012'`

# Searches all files in ./public and add them to manifest
while IFS= read -r line
do
  echo -e "$line\r" >> $CACHE_MANIFEST_FILE
done <<< "$RESOURCES_CONTENT"

echo "
#=========================================================.
# lists all URLs that have to be loaded over the Internet |
#========================================================='
NETWORK:
*

#================================================================================================================.
# lists replacements for network URLs to be used when the browser is offline or the remote server is unavailable |
#================================================================================================================'
#FALLBACK:
#/ /offline.html" >> $CACHE_MANIFEST_FILE