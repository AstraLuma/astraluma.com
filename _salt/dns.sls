"astraluma_com_a":
  boto_route53.present:
    - name: astraluma.com.
    - value:
{% for ip in salt['dnsutil.A']('astronouth7303.gitlab.io.') %}
      - {{ip}}
{% endfor %}
    - zone: astraluma.com.
    - record_type: A
    - ttl: 60

astraluma_com_txt_gitlab:
  boto_route53.present:
    - name: _gitlab-pages-verification-code.astraluma.com
    - value: 
      - '"gitlab-pages-verification-code=6b943be684694667a7240452000579be"'
    - zone: astraluma.com.
    - record_type: TXT
    - ttl: 60

astraluma_com_txt:
  boto_route53.present:
    - name: astraluma.com
    - value: 
      - '"google-site-verification=iY3OsqvdQv4R3OOACR-bRsyG-26ctP4vy1aHoAky5oU"'
      - '"v=spf1 include:aspmx.googlemail.com ~all"'
      - '"keybase-site-verification=dhGBCvEbvOVLXUX5IZQIQ-Pmm6JIIJu1Fe-aKL4wR3U"'
    - zone: astraluma.com.
    - record_type: TXT
    - ttl: 60

astraluma_com_mx:
  boto_route53.present:
    - name: astraluma.com
    - value: 
      - '1 ASPMX.L.GOOGLE.COM.'
      - '5 ALT1.ASPMX.L.GOOGLE.COM.'
      - '5 ALT2.ASPMX.L.GOOGLE.COM.'
      - '10 ASPMX2.GOOGLEMAIL.COM.'
      - '10 ASPMX3.GOOGLEMAIL.COM.'
    - zone: astraluma.com.
    - record_type: MX
    - ttl: 60
