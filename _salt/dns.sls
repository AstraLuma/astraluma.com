{% for ip in salt['dnsutil.A']('astronouth7303.gitlab.io.') %}
"astraluma_com_a_{{ip}}":
  boto_route53.present:
    - name: astraluma.com.
    - value: {{ip}}
    - zone: astraluma.com.
    - record_type: A
    - ttl: 60
{% endfor %}

# Maybe someday this will be usable
astraluma_com_txt:
  boto_route53.present:
    - name: _gitlab-pages-verification-code.astraluma.com
    - value: '"gitlab-pages-verification-code=6b943be684694667a7240452000579be"'
    - zone: astraluma.com.
    - record_type: TXT
    - ttl: 60
