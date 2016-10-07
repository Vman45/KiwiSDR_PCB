#
# Steps to creating manufacturing package:
#
#	openoffice:
#		edit docs/pcb.fab/quotation/kiwi.quotation.odt, create pdf
#	eeschema:
#		file > page settings: version, date on sch will get auto-updated
#		create bom
#		print > save-as-PDF to plot/kiwi.schematic.pdf
#	make, run through octopart.com
#	openoffice:
#		update docs/pcb.fab/quotation/$(MFG)/kiwi.bom.ods by hand from kiwi.bom.ods.csv and octopart.com prices
#			update pcb version # in title block
#		save-as to docs/pcb.fab/quotation/$(MFG)/kiwi.bom.xls
#			THEN re-save .xls after setting optimal-row-height +0.1mm to overcome row height bug
#	pcbnew:
#		edit version on top title comment bar
#		plot, drill/map/report
#		fab-out .pos: mm, one-file for board, makes plot/kiwi-all.pos
#		[assembly diagram optional for now]
#			print top & bot assembly diagram PDFs via print menu:
#			set ref text color via "visibles > render" side-menu button color
#			must be checked in "visibles layer" side-menu: f.silk dwgs.user eco1.user
#			sel print panel technical layers: f/b.mask (to get pads printed) f.silk dwgs.user eco1.user
#			sel print panel: single page, def pen 0.05mm, plot/kiwi.assembly.top/bot.pdf
#			bug: makes multiple identical pages for as many technical layers selected (4)
#	mpcb
#

PROJ = kiwi
MFG = _specify_on_make_invocation_
VER = _specify_on_make_invocation_

.PHONY: all
all: pn
	./pn

.PHONY: run
run: pn
	./pn 1

pn: ../tools/pn.c
	cc -g -DPROJECT=$(PROJ) -I. ../tools/pn.c -o pn

DIR_MFG = ../../docs/mfg/$(MFG)/$(VER)
#QUOTE_MFG = $(DIR_MFG)/kiwi.quotation.pdf
#QUOTE = $(PROJ).quotation.pdf
#QUOTE = 
BOM_MFG = $(DIR_MFG)/$(PROJ).bom.ods $(DIR_MFG)/$(PROJ).bom.xls
BOM = $(PROJ).bom.ods $(PROJ).bom.xls
SCH = $(PROJ).schematic.pdf

# called by mpcb alias
.PHONY: package
package:
	@echo making PCB package for mfg $(MFG) version $(VER)
	mkdir -p plot
#	cp $(QUOTE_MFG) plot
	cp $(BOM_MFG) plot
#	(cd plot; tar cf $(PROJ).$(VER).tar $(PROJ)*.g?? $(PROJ)*.drl $(PROJ)*.pos *.rpt $(BOM) $(SCH) $(QUOTE))
	(cd plot; tar cf $(PROJ).$(VER).tar $(PROJ)*.g?? $(PROJ)*.drl $(PROJ)*.pos *.rpt $(BOM) $(SCH))

.PHONY: clean
clean:
#	rm -f pn plot/$(QUOTE) $(addprefix plot/, $(BOM)) plot/$(PROJ).*.tar *.bak *-bak plot/*.zip
	rm -f pn $(addprefix plot/, $(BOM)) plot/$(PROJ).*.tar *.bak *-bak plot/*.zip
	rm -rf *.dSYM

#
# Steps to creating docs for website:
#
#	openoffice: save-as for kiwi.bom.xls if necessary
#	eeschema:
#		KiwiSDR.pro: print-save-as-PDF to plot/kiwi.schematic.pdf
#		active_antenna_comb.pro: print-save-as-PDF to ant.pdf
#		active_ant_opts.pro: print-save-as-PDF to ant.opts.pdf
#	pcbnew:
#		make sure gerbers, drill etc. up-to-date
#	mweb
#

DST = _specify_on_make_invocation_
ANT = ../active_antenna_comb/comb.pdf
ANT_OPTS = ../active_ant_opts/ant.opts.pdf
DSGN = ../../docs/design.review/KiwiSDR.design.review.pdf

# called by mweb alias
.PHONY: web
web:
	cp $(DSGN) $(DST)/../wrx/wrx.design.review.pdf
	cp $(DSGN) ~/Dropbox/Public/KiwiSDR
	cp $(PROJ).bom.csv $(BOM) plot/$(DOC) $(ANT) $(ANT_OPTS) $(DSGN) $(DST)
	(cd plot; tar cf $(DST)/$(PROJ).gerbers.tar $(PROJ)*.g?? $(PROJ)*.drl $(PROJ)*.pos *.rpt)
