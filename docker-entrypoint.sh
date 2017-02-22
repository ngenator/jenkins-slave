#!/bin/bash

set -e

ARGS=""

if [ -n "${JENKINS_USER}" ]; then
    ARGS="${ARGS} -username ${JENKINS_USER}"
fi

if [ -n "${JENKINS_PASS}" ]; then
    ARGS="${ARGS} -passwordEnvVariable JENKINS_PASS"
fi

if [ -n "${SWARM_EXECUTORS}" ]; then
    ARGS="${ARGS} -executors ${SWARM_EXECUTORS}"
fi

if [ -n "${JENKINS_MASTER}" ]; then
    ARGS="${ARGS} -master ${JENKINS_MASTER}"
    dockerize -wait ${JENKINS_MASTER} -timeout 2m;
fi

exec java \
    -jar /usr/share/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar \
    -fsroot ${HOME} \
    ${ARGS} \
    "$@"
