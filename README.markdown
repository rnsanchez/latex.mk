Overview
========

latex.mk contains a set of BSD-make rules to simplify document generation using
LaTeX.  The latex.mk file provides a set of basic rules, like PDF generation, so
the actual Makefile becomes very simple.


Using latex.mk
==============

You can start with a basic Makefile that sets the document entrypoint and
include latex.mk for document-building rules:

	# Document entrypoint.
	TEX_MAIN =      main.tex

	# Include BSD Make rules from latex.mk file.
	.include "latex.mk"

This should be enough to generate the document using the build targets described
next.  Additional elements can be included, such as figures and bibliography
database, also discussed next.


Build Targets
=============

latex.mk defines some build targets that are common when building the document:

* dvi: build up to the DVI (device independent) output.
* ps: build a PostScript from the DVI output.
* pdf: build a PDF from the PostScript output.
* rtf: converts the document to RTF (Rich Text Format), using latex2rtf.

There are some handy targets for visualizing the document (which includes the
build, if necessary):

* view: open a DVI viewer (eg: xdvi) to visualize the DVI output.
* viewps: open a PostScript viewer (eg: gv) to visualize the PostScript
  output.
* viewpdf: open a PDF viewer (eg: xpdf) to visualize the PDF output.


Including Dependencies
======================

As the document becomes more complex, one can describe its dependencies in a
more detailed way so rebuilds are correctly performed by make:

BIB_SRC
-------

If defined, instructs make to include a BibTeX pass in the build.  It actually
requires 1 LaTeX pass, 1 BibTeX, and another 2 LaTeX passes to get citations
right.


FIGURES
-------

If defined, includes dependencies for figures.  In fact, the files do not need
to be actual figures, since no tests are performed.  However, it keeps the
Makefile organized, and let other authors know which figures the document is
using.

Example:

	FIGURES = a.eps dir/b.eps dir2/c.eps

If you're feeling overwhelmed by too many figures to keep track, it is possible
to specify globs:

	FIGURES = figures/*.eps

This makes the build conditional to all EPS files in directoy "figures/".


TEX_SRC
-------

If the document is split into multiple .tex files, this is the way to indicate
the dependencies.

Example:

	TEX_SRC = main.tex \
			intro.tex \
			theory.tex \
			conclusion.tex


Overriding Options
==================

The default options in latex.mk can be overriden by defining either of the
following variables.


DVI_VIEWER
----------

Overrides the default DVI viewer (xdvi).


DVIPS_PRINT
-----------

Overrides the default printer options.  Example:

	DVIPS_PRINT = -ta4 -Pcmz


DVIPS_OPTIONS
-------------

Passes additional options to dvips.


PAPER
-----

Overrides the default paper size (letter) to be used by dvips.  Example:

	PAPER = a4


PDF_VIEWER
----------

Overrides the default PDF viewer (xpdf).


PS_VIEWER
---------

Overrides the defauls PostScript viewer (gv).



