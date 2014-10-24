#!/bin/bash

CACHE_MANIFEST_FILE='./private/html5/base/cache.manifest' # Saves working directory into variable
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

echo "-----------------------------------------------------"

# Searches files path in manifest that doesn't appear in ./public subfolders and deletes them.
while IFS= read -r line 
do
  if [[ "$line" =~ ^\/* ]]
    then
      is_in_directories=`grep $line $VIEWS_CONTENT | wc -l`
      echo 'hi'
      if [ $is_in_directories -ne 0 ]
        then
          echo $is_in_directories
          awk "{gsub($line, '')}" <<< proof
      fi
  fi

  echo "-----------------------------------------------------"

done <<< proof

echo "-----------------------------------------------------"