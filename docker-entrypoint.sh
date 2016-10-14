#!/bin/bash

SWARM_ARGS="";

if [ -n "${JENKINS_USER}" ]; then
    SWARM_ARGS="${SWARM_ARGS} -username ${JENKINS_USER}";
fi;

if [ -n "${JENKINS_PASS}" ]; then
    SWARM_ARGS="${SWARM_ARGS} -passwordEnvVariable JENKINS_PASS";
fi;

if [ -n "${SWARM_EXECUTORS}" ]; then
    SWARM_ARGS="${SWARM_ARGS} -executors ${SWARM_EXECUTORS}";
fi;

if [ -n "${JENKINS_MASTER}" ]; then
    SWARM_ARGS="${SWARM_ARGS} -master ${JENKINS_MASTER}";
fi;

exec java \
    -jar /usr/share/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar \
    -fsroot ${JENKINS_HOME} \
    ${SWARM_ARGS} \
    "$@";
