#
# Copyright © 2006--2009  Ricardo Nabinger Sanchez <rnsanchez@wait4.org>
# All rights reserved.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
# $Id$
#


.PHONY: all clean dvi pdf ps rtf view viewpdf viewps

all: dvi

clean:
	rm -f *.aux *.toc *.lo[agft] *.bbl *.blg *.out *.nav *.snm

#
# If the user has a BibTeX database, we must track its dependencies.
#
.if defined(BIB_SRC)
BBL	= ${TEX_MAIN:.tex=.bbl}
.else
BBL	=
.endif

#
# Files we know about.
#
DVI	= ${TEX_MAIN:.tex=.dvi}
PDF	= ${TEX_MAIN:.tex=.pdf}
PS	= ${TEX_MAIN:.tex=.ps}
RTF	= ${TEX_MAIN:.tex=.rtf}

DVI_VIEWER ?=	xdvi
PS_VIEWER ?=	gv
PDF_VIEWER ?=	xpdf

#
# Options
#
DEFAULT_PAPER =	letter
PAPER ?=	$(DEFAULT_PAPER)
DVIPS_PRINT ?=	-t $(PAPER) -Ppdf
DVIPS_OPTS ?=

#
# Rules to create the files we know about.
#
dvi: $(DVI)

pdf: $(PDF)

ps: $(PS)

rtf: $(RTF)

#
# Visualization.
#
view: dvi
	$(DVI_VIEWER) $(DVI_VIEWER_OPTS) $(DVI)

viewpdf: pdf
	$(PDF_VIEWER) $(PDF_VIEWER_OPTS) $(PDF)

viewps: ps
	$(PS_VIEWER) $(PS_VIEWER_OPTS) $(PS)

#
# If using BibTeX, and the database changed, we need the full run.
#
$(BBL): $(BIB_SRC)
	latex $(TEX_MAIN) && \
	bibtex ${TEX_MAIN:.tex=} && \
	latex $(TEX_MAIN) && \
	latex $(TEX_MAIN)

#
# If not using BibTeX, 2 LaTeX runs are necessary to ensure correct labels.
# Otherwise, make will instead go to the $(BBL) rule above, without running
# the commands in this one.
#
$(DVI): $(BBL) $(TEX_MAIN) $(TEX_SRC) $(FIGURES)
	latex $(TEX_MAIN) && \
	latex $(TEX_MAIN)

#
# Conversion among formats.
#
$(PDF): $(PS)
	ps2pdf $(PS)

$(PS): $(DVI)
	dvips $(DVIPS_PRINT) $(DVIPS_OPTS) $(DVI) -o $(PS)

$(RTF): $(TEX_MAIN) $(TEX_SRC) $(FIGURES)
	latex2rtf $(TEX_MAIN)

