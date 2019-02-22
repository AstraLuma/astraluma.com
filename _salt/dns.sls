#!pyobjects

def record(host, type, value):
    BotoRoute53.present(
        "%s_%s" % (host, type),
        name=host,
        value=value,
        zone="astraluma.com",
        record_type=type,
        ttl=(60*60),
    )


def alias(target, source, nameserver=None):
    ip4 = salt.dnsutil.A(source, nameserver=nameserver)
    if ip4:
        record(target, "A", ip4)

    ip6 = salt.dnsutil.AAAA(source, nameserver=nameserver)
    if ip6:
        record(target, "AAAA", ip6)

def getips(glob):
    ip4 = [
        ip
        for ips in salt.mine.get(glob, 'ipaddr.four').values()
        for ip in ips
    ]
    ip6 = [
        ip
        for ips in salt.mine.get(glob, 'ipaddr.six').values()
        for ip in ips
    ]
    return ip4, ip6

with BotoRoute53.hosted_zone_present(
    "astraluma.com.",
    domain_name="astraluma.com.",
    comment="",
):
    sh4, sh6 = getips('statichost-*')
    if sh4:
        record('astraluma.com', 'A', sh4)
        record('www.astraluma.com', 'A', sh4)
    if sh6:
        record('astraluma.com', 'AAAA', sh6)
        record('www.astraluma.com', 'AAAA', sh6)

    record("astraluma.com", "MX", [
        "10 in1-smtp.messagingengine.com.",
        "20 in2-smtp.messagingengine.com.",
    ])
    alias('mail.astraluma.com', 'mail.astraluma.com', nameserver='ns1.messagingengine.com')

    record("fm1._domainkey.astraluma.com", "CNAME", 'fm1.astraluma.com.dkim.fmhosted.com')
    record("fm2._domainkey.astraluma.com", "CNAME", 'fm2.astraluma.com.dkim.fmhosted.com')
    record("fm3._domainkey.astraluma.com", "CNAME", 'fm3.astraluma.com.dkim.fmhosted.com')

    record("astraluma.com", "TXT", [
        '"v=spf1 include:spf.messagingengine.com include:aspmx.googlemail.com ~all"',
        '"google-site-verification=iY3OsqvdQv4R3OOACR-bRsyG-26ctP4vy1aHoAky5oU"',
        '"keybase-site-verification=dhGBCvEbvOVLXUX5IZQIQ-Pmm6JIIJu1Fe-aKL4wR3U"',
    ])

    record("_gitlab-pages-verification-code.astraluma.com", "TXT", [
        '"gitlab-pages-verification-code=6b943be684694667a7240452000579be"'
    ])
