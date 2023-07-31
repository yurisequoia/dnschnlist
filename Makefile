SERVER=domestic
SMARTDNS_SPEEDTEST_MODE=tcp:80
NEWLINE=UNIX
SHELL=bash

raw:
	sed -e 's|^server=/\(.*\)/114.114.114.114$$|\1|' accelerated-domains.china.conf | grep -Ev '^#' > accelerated-domains.china.raw.txt
	sed -e 's|^server=/\(.*\)/114.114.114.114$$|\1|' apple.china.conf | grep -Ev '^#' > apple.china.raw.txt

smartdns-domain-rules: raw
	sed -e "s|\(.*\)|domain-rules /\1/ -speed-check-mode $(SMARTDNS_SPEEDTEST_MODE) -nameserver $(SERVER)|" accelerated-domains.china.raw.txt > accelerated-domains.china.domain.smartdns.conf
	sed -e "s|\(.*\)|domain-rules /\1/ -speed-check-mode $(SMARTDNS_SPEEDTEST_MODE) -nameserver $(SERVER)|" apple.china.raw.txt > apple.china.domain.smartdns.conf

clean:
	rm -f {accelerated-domains,google,apple}.china.*.conf *.smartdns.conf {accelerated-domains,google,apple}.china.raw.txt dnscrypt-proxy-forwarding-rules.txt
