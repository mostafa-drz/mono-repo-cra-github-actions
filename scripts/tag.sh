#!/bin/bash
set -e # exit on any error
set -x

if [ "${DRONE_TAG}" != "" ]; then
  echo "Trying to create a new git tag, while being on git tag already"
  exit 1
fi

VERSION_TODAY=$(date +'v%-y.%-m.%-d') # ie. v18.10.2
LAST_TAG_TODAY=$(git tag -l --sort=v:refname | grep $VERSION_TODAY | tail -1)

NEW_TAG=""

case $LAST_TAG_TODAY in
"")
  NEW_TAG=$VERSION_TODAY-1 # v18.10.2-1
  ;;
*)
  LAST_INCREMENT=$(echo $LAST_TAG_TODAY | cut -d- -f2)
  NEW_TAG=$VERSION_TODAY-$((++LAST_INCREMENT)) # v18.10.2-3 .. v18.10.2-N
  ;;
esac

git tag $NEW_TAG
git push --tags

echo "Created new git tag $NEW_TAG"