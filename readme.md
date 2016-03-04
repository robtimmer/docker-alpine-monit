alpine-monit
=============

A base image to run anything. It's based in alpine-basic, adding monit as process management

##Build

```
docker build -t <repo>/alpine-monit:<version> .
```

## Process management

This image compiles and intall [monit][monit] under /opt/monit, to make it super simple to start multiple process and manage them correctly.


## Versions

- `0.3.3` [(Dockerfile)](https://github.com/rawmind0/docker-alpine/blob/master/alpine-base/Dockerfile)

[See VERSIONS.md for image contents.](https://github.com/rawmind0/docker-alpine/blob/master/alpine-base/VERSIONS.md)

## Usage

To use this image include `FROM rawmind/alpine-monit` at the top of your `Dockerfile`. Starting from `rawmind/alpine-monit` provides you with the ability to easily start any service using monit. monit will also keep it running for you, restarting it when it crashes.

To start your service using monit:

- create a monit conf file in `/opt/monit/etc/conf.d`
- create a service script that allow start, stop and restart function
- example monit and script files:

monit conf
```
check process <service> with pidfile <service-pid-file>
  start program = "<path>/service.sh start"
  stop program = "<path>/service.sh stop"
  if failed port <port> type tcp then restart
```

service script
```
#!/usr/bin/env bash

SERVICE_NAME=zk
SERVICE_HOME=${SERVICE_HOME:-"<service-home>"}
SERVICE_CONF=${SERVICE_CONF:-"0"}

function log {
        echo `date` $ME - $@
}

function serviceStart {
    log "[ Starting ${SERVICE_NAME}... ]"
    <commands to start service>
}

function serviceStop {
    log "[ Stoping ${SERVICE_NAME}... ]"
    <commands to stop service>
}

function serviceRestart {
    log "[ Restarting ${SERVICE_NAME}... ]"
    serviceStop
    serviceStart
}

case "$1" in
        "start")
            serviceStart
        ;;
        "stop")
            serviceStop
        ;;
        "restart")
            serviceRestart
        ;;
        *) echo "Usage: $0 restart|start|stop"
        ;;

esac
```


## Examples

An example of using this image can be found in the [rawmind/alpine-zk][alpine-zk].

[monit]: https://mmonit.com/monit/
