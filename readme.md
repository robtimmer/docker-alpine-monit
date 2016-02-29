alpine-monit
=============

Builds a alpine-monit base image with monit compiled and installed in /opt/monit.

Basic config of monit its included, making able to copy monit conf files in /opt/monit/etc/conf.d and/or /opt/tools/conf.d if you use alpine-conf

To build

```
docker build -t <repo>/alpine-monit:<version> .
```

To run

```
docker run -it <repo>/alpine-monit:<version> 
```

