TEXFILES = $(wildcard *.tex)
PNGFILES = $(TEXFILES:.tex=.png)

TEX2HTML = tools/tex2html
CSSFILE = tools/index.css

.PHONY: all clean
all: $(PNGFILES) $(TEX2HTML) $(CSSFILE)
	$(TEX2HTML) $(TEXFILES) | xmllint --encode ASCII - > html/index.html
	ln -f $(CSSFILE) html/index.css
	ln -f $(PNGFILES) html/

clean:
	$(RM) *.aux *.dvi *.log *.png html/* xyling.sty

xyling.dvi: xyling.sty

xyling.sty:
	wget http://tug.ctan.org/macros/latex/contrib/xyling/xyling.sty
	sed -i -e 's/\RequirePackage\[color,all,dvips\]{xy}/\RequirePackage[color,all]{xy}/' xyling.sty

%.dvi: %.tex
	latex $(<)

%.png: %.dvi
	dvipng -D 200 -T tight -o /dev/stdout $(<) | gm convert -border 16x16 -bordercolor white PNG:- $(@)

# vim:ts=4 sw=4
