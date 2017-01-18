# Toran Proxy (Docker)

### Local

- Clone the repo onto your machine.
- Copy `config/local.env.dist` to `config/local.env`
- Fill in the data in `config/local.env`

```bash
$ docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d --build
```

The site will be available at `toran.dev` assuming you have it pointed to the Docker IP

### Production

- Use docker-machine to spin up a new machine
- Point a domain to that machine
- Get some certs [(guide)](https://www.brandpending.com/2016/09/06/using-the-lets-encrypt-docker-image-to-create-and-renew-an-ssl-certificate-for-an-nginx-web-site/), this works on the LetsEncrypt paths
- Clone the repo onto your machine.
- Copy `config/production.env.dist` to `config/production.env`
- Fill in the data in `config/production.env`
- Edit `config/nginx/toran.conf` to work with your domain

```bash
// Ensure docker commands are sent to the new remote machine and start
$ eval $(docker-machine env machine-name-here)
$ docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build
```

The site will be available at your domain, with HTTPS, HTTP/2 & optionally HTTP Auth :sunglasses: 
