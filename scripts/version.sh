#!/bin/bash
set -e

export LONGVERSION=$(git describe --tags --long --abbrev=8 --always HEAD || :)$(echo -"$DRONE_BRANCH" | tr / - | grep -v '\-master' || :)
export VERSION=${DRONE_TAG:-$LONGVERSION}
export REACT_APP_VERSION=${DRONE_TAG:-$LONGVERSION}