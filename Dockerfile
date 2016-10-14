FROM jenkins:2.19.1-alpine

MAINTAINER Daniel Ng <ngenator@gmail.com>

USER root

RUN apk --update add --no-cache \
    ca-certificates \
    tar \
    && rm -rf /var/cache/apk/*

ENV SWARM_CLIENT_VERSION 2.2
ADD https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_CLIENT_VERSION}/swarm-client-${SWARM_CLIENT_VERSION}-jar-with-dependencies.jar /usr/share/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar
RUN chmod 644 /usr/share/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar

ENV DOCKER_VERSION 1.12.2
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz \
    && tar --strip-components=1 -xvzf docker-${DOCKER_VERSION}.tgz -C /usr/local/bin \
    && chmod +x /usr/local/bin/docker \
    && rm -rf docker-${DOCKER_VERSION}.tgz

VOLUME /var/lib/docker

ADD ./docker-entrypoint.sh /docker-entrypoint.sh

USER jenkins
WORKDIR ${JENKINS_HOME}

ENTRYPOINT ["/docker-entrypoint.sh"]
