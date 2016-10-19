# jenkins-slave

Jenkins slave in a container. Expects the master to have the [Swarm Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) installed.

## Environment Variables

| Variable        | Purpose        |
| :-------------  | :------------- |
| JENKINS_USER    | The user used to connect to the jenkins master     |
| JENKINS_PASS    | The password used to connect to the jenkins master |
| JENKINS_MASTER  | The location of the jenkins master: `http[s]://[address]:[port]`  |
| SWARM_EXECUTORS | The number of concurrent jobs the slave can process |
