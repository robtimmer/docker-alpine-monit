alpine-monit
=============

A base image to run anything. It's based in [alpine-base][alpine-base], adding monit as process management

## Build

```
docker build -t rawmind/alpine-monit:<version> .
```

## Process management

This image compiles and intall [monit][monit] under /opt/monit, to make it super simple to start multiple process and manage them correctly.

Starts automatically all services conf files that would be copied in /opt/monit/etc/conf.d or /opt/tools/monit/conf.d


## Versions

- `0.5.18-6` [(Dockerfile)](https://github.com/rawmind0/docker-alpine/blob/0.5.18-6/alpine-monit/Dockerfile) Monit version 5.18
- `0.3.3-2` [(Dockerfile)](https://github.com/rawmind0/docker-alpine/blob/0.3.3-2/alpine-base/Dockerfile) Monit version 5.16

## Usage

To use this image include `FROM rawmind/alpine-monit` at the top of your `Dockerfile`. Starting from `rawmind/alpine-monit` provides you with the ability to easily start any service using monit. monit will also keep it running for you, restarting it when it crashes.

To start your service using monit:

- create a monit conf file in `/opt/monit/etc/conf.d`
- create a service script that allow start, stop and restart function
- Implement serviceLog function if you want that your service log will be writed to docker logs command.
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

function serviceLog {
    log "[ Redirecting ${SERVICE_NAME} log... ]"
    ln -sf /proc/1/fd/1 <service log file>
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
            serviceLog
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

An example of using this image can be found in the [alpine-zk][alpine-zk].

[monit]: https://mmonit.com/monit/
[alpine-base]: https://github.com/rawmind0/alpine-base/
[alpine-zk]: https://github.com/rawmind0/alpine-zk
