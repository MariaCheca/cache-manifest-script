#!/bin/bash

CACHE_MANIFEST_FILE='./public/mobile/cache.manifest' # Saves working directory into variable
echo "Directory test:" $CACHE_MANIFEST_FILE
echo "-----------------------------------------------------"

VIEWS_CONTENT=`find ./public -mindepth 3  -type f -not -path '*/\.*' | sed 's/.\/public//g'`
#echo "$VIEWS_CONTENT"

# Searches all files in ./public and add them to manifest if are not there.
while IFS= read -r line
do
  count=`grep $line proof | wc -l`
  if [ ! $count -ne 0 ]
    then
      echo -e "$line\r" >> proof
  fi
done <<< "$VIEWS_CONTENT"

# Searches files path in manifest that doesn't appear in ./public subfolders and deletes them.
while IFS= read -r line 
do
  if [[ $line =~ ^\/ ]]
    then
      sed '/\$line\/d' proof
  fi
done <<< "$VIEWS_CONTENT"