TEXFILES = $(wildcard *.tex)
PNGFILES = $(TEXFILES:.tex=.png)

.PHONY: all clean
all: $(PNGFILES)

clean:
	$(RM) *.aux *.dvi *.log *.png	


%.dvi: %.tex
	latex $(<)

%.png: %.dvi
	dvipng -D 300 -T tight -o /dev/stdout $(<) | gm convert -border 16x16 -bordercolor white PNG:- $(@)

# vim:ts=4 sw=4
