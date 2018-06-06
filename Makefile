# Copyright © 2007-2018 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

TEXFILES = $(wildcard *.tex)
PNGFILES = $(TEXFILES:.tex=.png)

TEX2HTML = tools/tex2html
CSSFILE = tools/index.css

.PHONY: all clean
all: $(PNGFILES) $(TEX2HTML) $(CSSFILE)
	mkdir -p html/
	$(TEX2HTML) $(TEXFILES) | xmllint --encode ASCII - > html/index.html
	ln -f $(CSSFILE) html/index.css
	ln -f $(PNGFILES) html/

clean:
	rm -rf *.aux *.dvi *.log *.png html/ xyling.sty

xyling.dvi: xyling.sty

xyling_sty = $(shell kpsewhich xyling.sty)
xyling.sty: $(xyling_sty)
	sed -e 's/\RequirePackage\[color,all,dvips\]{xy}/\RequirePackage[color,all]{xy}/' < $(<) > $(@).tmp
	mv $(@).tmp $(@)

%.dvi: %.tex
	latex $(<)

%.png: %.dvi
	dvipng -D 200 -T tight -o /dev/stdout $(<) | gm convert -border 16x16 -bordercolor white PNG:- $(@)

.error = GNU make is required

# vim:ts=4 sts=4 sw=4 noet
