nginx-lumami:
  service.running:
    - name: nginx
    - reload: true

/srv/astraluma.com:
  file.recurse:
    - source: salt://_artifacts/public
    - clean: true

astraluma.com:
  acme.cert:
    - email: webmaster@astraluma.com
    - webroot: /srv/certbot
    - watch_in:
        - service: nginx-lumami

www.astraluma.com:
  acme.cert:
    - email: webmaster@astraluma.com
    - webroot: /srv/certbot

/etc/nginx/sites-enabled/astraluma.com:
  file.managed:
    - watch_in:
      - service: nginx
    - require:
      - acme: astraluma.com
      - file: /srv/astraluma.com
    - contents: |
        server {
          listen 443;
          listen [::]:443;

          server_name astraluma.com;

          ssl_certificate /etc/letsencrypt/live/astraluma.com/fullchain.pem;
          ssl_certificate_key /etc/letsencrypt/live/astraluma.com/privkey.pem;
          ssl_trusted_certificate /etc/letsencrypt/live/astraluma.com/chain.pem;

          location / {
            alias /srv/astraluma.com/;
          }
        }

/etc/nginx/sites-enabled/www.astraluma.com:
  file.managed:
    - watch_in:
      - service: nginx
    - require:
      - acme: www.astraluma.com
    - contents: |
        server {
          listen 443;
          listen [::]:443;

          server_name www.astraluma.com;

          ssl_certificate /etc/letsencrypt/live/www.astraluma.com/fullchain.pem;
          ssl_certificate_key /etc/letsencrypt/live/www.astraluma.com/privkey.pem;
          ssl_trusted_certificate /etc/letsencrypt/live/www.astraluma.com/chain.pem;

          return 301 https://astraluma.com$request_uri$is_args$args;
        }
