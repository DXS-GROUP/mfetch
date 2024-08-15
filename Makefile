PREFIX ?= /usr

all:
	@echo RUN \'make install\' to install mfetch

install:
	@install -Dm755 mfetch $(DESTDIR)$(PREFIX)/bin/mfetch

uninstall:
	@rm -f $(DESTDIR)$(PREFIX)/bin/mfetch
