Ryoca - a minimal e-mail classifier powered by [CRM114](https://crm114.sourceforge.net/)
============================================================

What's inside
---------------

* `ryoca` ... a email classifier
* `wktng` ... a text preprocessor, written in Perl, to get non-ascii parts in UTF-8 text separated into n-gram style
* `ryoca-bootcamp` ... an ad-hoc Bash script to initialize statistics in TOE strategy (read & modify before use!)
* `patches/` ... some small patches I personally apply to CRM114 & [normalizemime](http://hyvatti.iki.fi/~jaakko/spam/)

Quick start
-------------

Please do not forget to read `ryoca` and tweak some settings inside.

	$ sudo make install
	 
	$ ryoca --learn=good < GOOD_MAIL_TO_LEARN
      :
	$ ryoca --learn=junk < JUNK_MAIL_TO_LEARN
      :
	 
	$ ryoca < MAIL_TO_CLASSIFY
	  => prints original content with `X-CRM114-Status: (Good|Junk|Unsure)' header added

License
---------

Scripts are under GPLv3, same as CRM114 itself.

Patches are under the same licenses as the software to which each patch will be applied.

Thanks
--------

* CRM114's [`INTRO.txt`](http://crm114.sourceforge.net/docs/INTRO.txt) and [`QUICKREF.txt`](http://crm114.sourceforge.net/docs/QUICKREF.txt) for helping me to deeply understand CRM114
* [私は如何にして心配するのをやめてスパムを愛するようになったか \[CRM114の日本語対応\]](https://www.higuchi.com/item/121) for the idea to recognize multibyte texts in CRM114

FAQ
-----

### Why CRM114 in 2020s?

I had been using [Bogofilter](https://bogofilter.sourceforge.io/) for over a decade and been reasonably satisfied.
But preprocessing multibyte texts (e.g. tokenization), which Bogofilter isn't capable of, was the challenge to give a try for me receiving many Japanese emails.

CRM114 was the best to implement such email classifier without much effort.

Also, patching and installing CRM114 was super easy thanks to [Portage](https://wiki.gentoo.org/wiki/Portage) on my [Gentoo Linux](https://www.gentoo.org/) server.

### Why not official scripts?

One of the Ryoca's design goal is to be an simple, minimized version of the official `mail(filter|reaver).crm`.
They seem to be too massive for me to handle trustfully.

Yes, for some extent, I'm reinventing the wheel.

Yet, Ryoca is a pure CRM114 script and utilizes the strong classifier in (hopefully) proper way.
I believe its core functionality is guaranteed.
Also it might be a good small sample for those who want to write their own CRM114 scripts.

### How do you use it?

I use [Dovecot](https://dovecot.org/), calling Ryoca via:

* Sieve script, to add classification header to receiving emails and filter spams out
* IMAPSieve script, to re-learn when I manually move emails into (or out of) specific IMAP folder

Here are some hints:

* [Pigeonhole Sieve examples — Dovecot documentation](https://doc.dovecot.org/configuration_manual/sieve/examples/)
* [Pigeonhole Sieve: Extprograms Plugin — Dovecot documentation](https://doc.dovecot.org/configuration_manual/sieve/plugins/extprograms/)
* [Replacing antispam plugin with IMAPSieve — Dovecot documentation](https://doc.dovecot.org/configuration_manual/howto/antispam_with_sieve/)

Please keep in mind that:

* `sieve_<extension>_input_eol` must be set to `lf` because Ryoca doesn't support emails with CRLF line endings
* `vsz_limit` for `imap` service ([256M default](https://doc.dovecot.org/settings/core/#core_setting-default_vsz_limit)) might be insufficient for invoking CRM114 via IMAPSieve, especially with the data window size expanded by the patch

### What did the name come from?

I had watched a movie [Library Wars](https://en.wikipedia.org/wiki/Library_Wars_(film)) (図書館戦争, Toshokan Sensō) just after starting development.
There appeared a fictional organization called Media Betterment Committee (メディア良化委員会, Media Ryōka Iinkai)
and its military Media Betterment Force (メディア良化隊, Media Ryōka Tai).

They burn books, relentlessly.

Disclaimer: I'm definitely against censorship and burning books, although I burn spams sent to me with pleasure.
