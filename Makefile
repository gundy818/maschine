
AMEBA	:= bin/ameba
AMEBAFLAGS	:= --except Style/RedundantReturn,Layout/TrailingBlankLines

CRYSTAL	:= crystal
CRYSTALFLAGS	:=


all:
	@echo Hi

clean:

check:	lint check_spec

check_spec:
	$(CRYSTAL) $(CRYSTALFLAGS) spec

lint:
	$(AMEBA) $(AMEBAFLAGS)

doc:	$(DOCS)

TAGS:
	ctags -R .

.PHONY:	all check_spec clean doc lint

