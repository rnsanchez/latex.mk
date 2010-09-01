#
# Copyright © 2009  Ricardo Nabinger Sanchez <rnsanchez@wait4.org>
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
# Example Makefile to use with latex.mk.
#

# Document entrypoint.
TEX_MAIN =	main.tex

# Additional .tex files of this document.
#TEX_SRC =

# BibTeX database.  Multiple databases aren't quite supported yet---sorry.
#BIB_SRC =	main.bib

# Figures of this document (.eps, ...).
#FIGURES =

# Include BSD Make rules from latex.mk file.
.include "latex.mk"
