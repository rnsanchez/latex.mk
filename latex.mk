#
# Copyright (c) 2006, 2007  Ricardo Nabinger Sanchez <rnsanchez@wait4.org>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#   * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#   * Neither the name of the Copyright owner nor the names of its contributors
#   may be used to endorse or promote products derived from this software
#   without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# $Id$
#


.PHONY: all clean dvi pdf ps rtf view viewpdf viewps

all: dvi

clean:
	rm -f *.aux *.toc *.lo[agft] *.bbl *.blg *.dvi *.out *.nav *.snm

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
DVIPS_PRINT ?=	-Ppdf
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
	latex $(TEX_MAIN)
	bibtex ${TEX_MAIN:.tex=}
	latex $(TEX_MAIN)
	latex $(TEX_MAIN)

#
# If not using BibTeX, 2 LaTeX runs are necessary to ensure correct labels.
# Otherwise, make will instead go to the $(BBL) rule above, without running
# the commands in this one.
#
$(DVI): $(BBL) $(TEX_MAIN) $(TEX_SRC)
	latex $(TEX_MAIN)
	latex $(TEX_MAIN)

#
# Conversion among formats.
#
$(PDF): $(PS)
	ps2pdf $(PS)

$(PS): $(DVI)
	dvips $(DVIPS_PRINT) $(DVIPS_OPTS) $(DVI) -o $(PS)

$(RTF): $(TEX_MAIN)
	latex2rtf $(TEX_MAIN)

