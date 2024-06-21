.PHONY: install test
install: ryoca wktng
	install -v -o root -g root -m 0755 -t /usr/local/bin/ $^

test:
	@for d in \
		~/Maildir/.Archives/cur \
		~/Maildir/.Junk/cur \
	; do \
		echo; \
		for f in `find $$d -type f | shuf -n5`; do \
			echo -e "-- \n$$f"; \
			./ryoca < $$f | grep -C2 ^X-CRM114-; \
		done; \
	done
