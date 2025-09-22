description of datasets:

First, the selex dataset (PMID 24912189). This is from an in-vitro selection experiment where we are
reading out the enzymatic activity of 1600 mutants of one enzyme. In this dataset every mutant is
independent, there is no correlation between them and no way for a synthetic association to arise.
The experiment is growth under non-selective conditions (control), where the enzyme has no effect,
and growth under selective conditions, where the bacteria with the active enzyme will grow and those
with inactive enzyme will neither grow, nor die. Thus, it is a perfect example of a positive change
in one direction only. About 2-3% of the enzymes are active, and the rest are inactive. We have a
standard of truth for these enzymes and know which are active and which are not from both in-vitor
biochemistry and from evolutionary inference. The abundance variance relationship is almost nil

conds.selex <- c(rep("N",7), rep("S",7))

Second, the Barton transcriptome dataset (PMID 27022035). This is a highly replicated RNA seq
experiment examining what happens when a single yeast gene (SNF2) is knocked out. Here we have 48
replicates in each group (WT, KO) and about 6000 genes. The abundance variance relationship in this
experiment is extremely tight and using standard tools about 2/3 of genes are 'statistically
significant' different between groups. A codicil in this experiment is that it was originally
designed to test the ability of spike-in sequences to normalize the data off the simplex. It turned
out that the second largest source of variance for this dataset was the batch number of the spike-in
reagent and this aim was quietly dropped.

conds.tsc <- c(rep("SNF",48), rep("WT",48))


Third, a 16S rRNA genes sequencing dataset from a large scale population survey (PMID 28959739).
Here I have extracted out the school-aged children and the centenarians with over 150 samples in
each group and several thousand OTUs. The variance abundance relationship is intermediate, but the
data are very sparse. We of course have no standard of truth but many OTUs are differentially
abundant in each group. This dataset was collected by a very dedicated team and is among the
cleanest 16S datasets I have access to.

conds.16S <- c(rep("PUP",198), rep("CENT",161))

Fourth, a single cell transcriptome dataset 

conds.ss <- c(rep('cyt', 1000), rep('mem', 1000))

Fifth

a meta-transcriptome dataset 

  # pull out the H and BV samples
  h.24 <- c("X001B", "X002B", "X004B", "X006B", "X009B", "X010B", "X020B")

  bv.24 <- c("X006A", "X008A", "X009A", "X010A", "X012B", "X014B", "X018B", "X017B", "X012A", "X013A")

  d.24 <- data.frame(d.24.init[,h.24], d.24.init[,bv.24], check.names=F)


# datasets and descriptions


## to use GSE29087_L139_expression_tab
  - source: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE29087
  - paper: https://pmc.ncbi.nlm.nih.gov/articles/PMC3129258/

### basic load and filter code
URL <- "https://github.com/ggloor/datasets/blob/main/GSE29087_L139_expression_tab.txt"
d <- read.table(URL,  skip=14, sep='\t')
# keep columns 8-99
d.count <- d[,8:99]
# replace row offsets with gene names
rownames(d.count) <- d[,1]

#### filter to remove rows with fewer than 5 non 0 entries
	# ie minimum prevalence of 5/92 or 5.4%
#### Q filter to remove rows with fewer than 45 non 0 entries
	## minimum prevalence of 50%
#### make a vector of the number of non-0 samples in each row
filt <- apply(d.count, 1, function(x) length(which(x > 0)))
d.filt <- d.count[which(filt > 4),]

#### change column names to be either E or M
nms <- colnames(d.filt)
nms[1:46] <- gsub("V", "E", nms[1:46])
nms[47:92] <- gsub("V", "M", nms[1:46])
colnames(d.filt) <- nms
 

