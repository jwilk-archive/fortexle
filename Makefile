TEXFILES = $(wildcard *.tex)
PNGFILES = $(TEXFILES:.tex=.png)

TEX2HTML = tools/tex2html
CSSFILE = tools/index.css

.PHONY: all clean
all: $(PNGFILES) $(TEX2HTML) $(CSSFILE)
	$(TEX2HTML) $(TEXFILES) > html/index.html
	ln -f $(CSSFILE) html/index.css
	ln -f $(PNGFILES) html/

clean:
	$(RM) *.aux *.dvi *.log *.png html/*

%.dvi: %.tex
	latex $(<)

%.png: %.dvi
	dvipng -D 300 -T tight -o /dev/stdout $(<) | gm convert -border 16x16 -bordercolor white PNG:- $(@)

# vim:ts=4 sw=4
