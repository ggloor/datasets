# abundance vs dispersion plots

library(ALDEx2)
data(selex)
x <- aldex.clr(selex, conds=c(rep('n',7), rep('s', 7)))
sel.e <- aldex.effect(x)

# single cell
load('ss.effect.Rda') # see make-single-cell.R

tsc <- read.table('transcriptome.tsv', header=T, row.names=1, sep='\t')
x <- aldex.clr(tsc, conds=c(rep('n',48), rep('s', 48)))
tsc.e <- aldex.effect(x)

meta <- read.table('meta16S.tsv', header=T, row.names=1, sep='\t')
x <- aldex.clr(meta, conds=c(rep('n',198), rep('s', 161)))
meta.e <- aldex.effect(x)

# meta-transciptome
load('~/Documents/0_git/twntyfr/VIRGO/Rdata/x.all.Rda')

pdf(file='disp-v-abund.pdf', height=7, width=7)

plot(tsc.e$diff.win, tsc.e$rab.all, pch=19, cex=0.5, col=rgb(0,0,.7,0.4),
  xlim=c(0,12), ylim=c(-14,11), xlab='dispersion', ylab='rAbundance')

points(meta.e$diff.win, meta.e$rab.all, pch=19, cex=0.5, col=rgb(0,0,0,0.1))

points(sel.e$diff.win, sel.e$rab.all, pch=19, cex=0.5, col=rgb(1,0,0,0.5))

# single cell transcriptome
points(ss.effect$diff.win, ss.effect$rab.all, pch=19, cex=0.5, col=rgb(0,.8,.8,0.5))

# meta-transcriptome
points(x.all$diff.win, x.all$rab.all, pch=19, cex=0.5, col=rgb(0.4,0.6,1,0.5))
# 16S
points(meta.e$diff.win, meta.e$rab.all, pch=19, cex=0.5, col=rgb(0,0,0,0.3))

legend(8, 10, legend=c('transcriptome', "single-cell-t'ome", "meta-t'ome", '16S-rRNA', 'selex'), col=c(rgb(0,0,.7,0.6), rgb(0,.8,.8,0.7), rgb(0.4,0.6,1,0.7), rgb(0,0,0,0.6), rgb(1,0,0,0.7)), pch=19)

dev.off()

