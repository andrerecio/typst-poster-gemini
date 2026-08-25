# ------------------------------------------------------------
# gemini-typst — build helpers
#   make            -> poster.pdf
#   make watch      -> live preview (recompiles on save)
#   make preview    -> PNG previews in preview/ (for the README)
#   make clean
# ------------------------------------------------------------
TYPST      ?= typst
FONTS      ?= fonts
MAIN       ?= poster.typ
PDF        := $(MAIN:.typ=.pdf)
PPI        ?= 60

.PHONY: all watch preview clean fonts

all: $(PDF)

$(PDF): $(MAIN) lib.typ themes.typ refs.bib $(wildcard logos/*)
	$(TYPST) compile --font-path $(FONTS) $(MAIN) $(PDF)

watch:
	$(TYPST) watch --font-path $(FONTS) $(MAIN) $(PDF)

preview: $(MAIN)
	mkdir -p preview
	$(TYPST) compile --font-path $(FONTS) --format png --ppi $(PPI) --input theme=navy $(MAIN) preview/poster-navy.png
	$(TYPST) compile --font-path $(FONTS) --format png --ppi $(PPI) --input theme=sapienza $(MAIN) preview/poster-sapienza.png

fonts:
	$(TYPST) fonts --font-path $(FONTS) | grep -iE "montserrat|source sans|computer modern"

clean:
	rm -f $(PDF)
