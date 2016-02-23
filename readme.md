InnoTech-alpine-ssl
=====================

See the wiki  http://cfwiki.innotechapp.com/mediawiki/index.php/Docker_images to see how we build images.

Builds a alpine-ssl image with openssl and extra software installed. (bash openssl curl file)

```
docker build -t <repo>/alpine-ssl:<version> .
```

To run:

```
docker run -it <repo>/alpine-ssl:<version> 
```

