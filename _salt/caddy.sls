caddy-astraluma:
  service.running:
    - name: caddy
    - reload: true

/srv/astraluma.com:
  file.recurse:
    - source: salt://_artifacts/public
    - clean: true

/etc/caddy/sites/astraluma.com:
  file.managed:
    - watch_in:
      - service: caddy-astraluma
    - require:
      - file: /srv/astraluma.com
    - contents: |
        astraluma.com {
          import logging
          root * /srv/astraluma.com
          file_server
        }

        www.astraluma.com {
          import logging
          redir https://astraluma.com{uri} 301
        }
