
SHELL	:= /bin/sh
PACKAGE	:= naschine
VERSION	:= $(shell date +%Y%m%d)

AMEBA	:= bin/ameba
AMEBAFLAGS	:= --except Style/RedundantReturn,Layout/TrailingBlankLines

CRYSTAL	:= crystal
CRYSTALFLAGS	:=


all:
	@echo Hi

clean:

check:	check_spec

check_spec:
	$(CRYSTAL) $(CRYSTALFLAGS) spec

lint:
	$(AMEBA) $(AMEBAFLAGS)

doc:	$(DOCS)

TAGS:
	ctags -R .

.PHONY:	all clean doc lint
