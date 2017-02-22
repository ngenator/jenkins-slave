FROM jenkins:alpine

MAINTAINER Daniel Ng <ngenator@gmail.com>

ENV JENKINS_USER=${JENKINS_USER:-jenkins}
ENV JENKINS_PASS=${JENKINS_PASS:-jenkins}
ENV JENKINS_MASTER=http://master:8080

USER root

RUN apk --update add --no-cache \
    ca-certificates \
    tar \
    docker \
    && rm -rf /var/cache/apk/*

ENV SWARM_CLIENT_VERSION 3.3
ADD https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${SWARM_CLIENT_VERSION}/swarm-client-${SWARM_CLIENT_VERSION}.jar /usr/share/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar
RUN chmod 644 /usr/share/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar \
    && chown jenkins /usr/share/jenkins/swarm-client-${SWARM_CLIENT_VERSION}.jar

# Add dockerize so we can wait for the master to become available
ENV DOCKERIZE_VERSION v0.3.0
RUN curl -fsSLO https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && chmod +x /usr/local/bin/dockerize \
    && rm -rf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

VOLUME /var/lib/docker

WORKDIR ${JENKINS_HOME}

COPY ./docker-entrypoint.sh /

USER jenkins

ENTRYPOINT ["/docker-entrypoint.sh"]
