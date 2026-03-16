.PHONY: install check
install: ryoca bakshu
	install -v -o root -g root -m 0755 -t /usr/local/bin/ $^

check:
	@for d in \
		~/Maildir/.Archives/cur \
		~/Maildir/.Junk/cur \
	; do \
		find "$$d" -type f -print0 | shuf -z -n3 | xargs -0 -I{} sh -c 'ryoca < {}'; \
	done | grep --color -B1 -A2 '^X-CRM114-Status:.*'
