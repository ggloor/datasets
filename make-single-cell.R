# Data from: https://github.com/skinnider/SCT-MoA/tree/master/data/10xgenomics.com/processed
# https://github.com/skinnider/SCT-MoA
# suggested by Ionas

ct <- read.table('~/Downloads/Zheng_cytotoxic_t.txt', header=T, sep='\t')
dt <- read.table('~/Downloads/Zheng_memory_t.txt', header=T, sep='\t')

#Samples by row

# collect cells in the upper quartile of reads for two cell types
ct.abund <- ct[rowSums(ct) > summary(rowSums(ct))[5],] # 2544 rows
dt.abund <- dt[rowSums(dt) > summary(rowSums(dt))[5],] # 2551 rows

# collect a common set of abundant reads in both cell types
dt.true <- colSums(dt.abund) > 300
ct.true <- colSums(ct.abund) > 300
both.true <- ct.true & dt.true # 1508 genes

ct.filt <- ct.abund[,both.true]
dt.filt <- dt.abund[,both.true]

# first biplot shows a lot of spread because of a small number of outliers 
# maybe 10% of Samples

# the code below removes those and replots

ct.clr <- apply(ct.filt+0.3, 1,   function(x) log(x) - mean(log(x)))
ct.outlier <- codaSeq.outlier(t(ct.clr))
ct.keep <- ct.filt[ct.outlier$good,]

dt.clr <- apply(dt.filt+0.3,  1,   function(x) log(x) - mean(log(x)))
dt.outlier <- codaSeq.outlier(t(dt.clr))
dt.keep <- dt.filt[dt.outlier$good,]

rownames(ct.keep) <- paste('R', rownames(ct.keep), sep='')
rownames(dt.keep) <- paste('B', rownames(dt.keep), sep='')
 
both.filt <- rbind(ct.keep, dt.keep) # 2376 cytotoxic, 2339 memory, 1508 genes

# reduce to 1500 samples chosen at random from each
ct.me <- rbind(ct.keep[1:1000,], dt.keep[1:1000,])

both.clr <- apply(ct.me+0.3, 1, function(x) log(x) - mean(log(x)))
group <- c(rep('red', 1500), rep('blue', 1500))

pcx <- prcomp(t(both.clr))
plot(pcx$x[,1], pcx$x[,2], col=group, pch=19, cex=0.5)

# without outlier removal this was useless since ordination
# separated outliers only
# with outlier removal looks OK, and separates on second dimension 
y.umap <- umap(t(both.clr))

plot(y.umap$layout[,1],y.umap$layout[,2], col=group, pch=19, cex=0.3)
