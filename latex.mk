#
# Copyright (c) 2006, Ricardo Nabinger Sanchez <rnsanchez@wait4.org>
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


.PHONY: all clean dvi pdf ps rtf view

all: dvi

clean:
	rm -f *.aux *.toc *.lo[gft] *.bbl *.blg *.dvi

dvi: $(TEX_MAIN).dvi

.if defined(WITH_BIBTEX)
BIBCMD = bibtex $(TEX_MAIN)
.else
BIBCMD =
.endif

pdf: $(TEX_MAIN).pdf

ps: $(TEX_MAIN).ps

rtf: $(TEX_MAIN).rtf

view: dvi
	xdvi $(TEX_MAIN)

$(TEX_MAIN).dvi: $(TEX_MAIN).tex $(TEX_SRC) $(BIB_SRC).bib
	latex $(TEX_MAIN)
	$(BIBCMD)
	latex $(TEX_MAIN)
	latex $(TEX_MAIN)

$(TEX_MAIN).pdf: $(TEX_MAIN).ps
	ps2pdf $(TEX_MAIN).ps

$(TEX_MAIN).ps: $(TEX_MAIN).dvi
	dvips -Ppdf $(TEX_MAIN).dvi -o $(TEX_MAIN).ps

$(TEX_MAIN).rtf: $(TEX_MAIN).tex
	latex2rtf $(TEX_MAIN).tex

