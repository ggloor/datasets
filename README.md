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
 

