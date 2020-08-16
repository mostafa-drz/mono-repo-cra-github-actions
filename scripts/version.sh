#!/bin/bash
set -e

export LONGVERSION=$(git describe --tags --long --abbrev=8 --always HEAD || :)$(echo -"${GITHUB_REF##*/}" | tr / - | grep -v '\-master' || :)
export VERSION=${DRONE_TAG:-$LONGVERSION}
export REACT_APP_VERSION=${github.sha:-$LONGVERSION}