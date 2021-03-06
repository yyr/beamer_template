MAKE = make
MAINDOC = p
RM = /bin/rm
PDFLATEX = xelatex --synctex=1

SOURCES = $(wildcard *.tex)

%.odt:
	latex2html ${MAINDOC}.tex -split 0 -no_navigation -info "" \
		-address "" -html_version 4.0,unicode

	libreoffice --headless --convert-to odt:"OpenDocument Text Flat XML" \
		${MAINDOC}/index.html

%.pdf: $(SOURCES)
	if $(PDFLATEX) $*.tex </dev/null; then \
		true; \
	else \
		stat=$$?; touch $*.pdf; exit $$stat; \
	fi

all: $(MAINDOC).pdf
pdf: $(MAINDOC).pdf

clean:
	$(RM) -f *.aux  *.blg *.log *~ *.bbl

cleanall : clean
	$(RM) -f *.dvi *.cfg *.idx *.ilg *.ind *.toc *.lot *.lof *.pdf *.out
	$(RM) -rf $(MAINDOC)

.PHONY: clean cleanall
