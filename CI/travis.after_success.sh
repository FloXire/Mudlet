#!/bin/bash

if [ "${TRAVIS_REPO_SLUG}" != "Mudlet/Mudlet" ]; then
  exit 0
fi

if [ -z "${TRAVIS_OS_NAME}" ] || [ "${TRAVIS_OS_NAME}" = "linux" ]; then
  echo Deploy on linux.
  . CI/travis.linux.after_success.sh;
fi
if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
  echo Deploy on OSX.
  . CI/travis.osx.after_success.sh;
fi

if [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then
  PR_ID=", #${TRAVIS_PULL_REQUEST}"
fi

if [ -n "${DEPLOY_URL}" ]; then
  curl \
    --data-urlencode "message=Deployed Mudlet \`${VERSION}${MUDLET_VERSION_BUILD}\` (${TRAVIS_OS_NAME}${PR_ID}) to [${DEPLOY_URL}](${DEPLOY_URL})" \
    https://webhooks.gitter.im/e/cc99072d43b642c4673a
fi

echo ""
echo "******************************************************"
echo ""
echo "Finished building Mudlet ${VERSION}${MUDLET_VERSION_BUILD}"
if [ -n "${DEPLOY_URL}" ]; then
    echo ""
    echo "Deployed the output to ${DEPLOY_URL}"
fi
echo ""
echo "******************************************************"
