#!/usr/bin/env bash

set -euxo pipefail

if [ ! -f "${THELOUNGE_HOME}/config.js" ]; then
  cp -v /opt/app-root/src/defaults/* ${THELOUNGE_HOME}/
fi

yarn start