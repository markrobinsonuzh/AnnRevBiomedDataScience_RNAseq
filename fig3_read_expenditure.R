
library(recount)
library(reshape2)
library(ggplot2)
library(dplyr)

# ?recount::download_study

# url <- download_study('ERP001942', download = FALSE)

url2 <- download_study('SRP060416')
load(file.path('SRP060416', 'rse_gene.Rdata'))
counts <- assays(rse_gene)$counts

# keep any genes where cpms > 1 in at least 5% of samples (arbitrary)
keep <- rowSums(edgeR::cpm(counts)>1) >= ncol(counts)*.05
table(keep)

counts <- counts[keep,sample(ncol(counts),50)]

cum <- apply(counts,2, function(u) {
  u <- sort(u, decreasing = TRUE)
  cumsum(u)/sum(u)
})

m <- melt(cum) %>% transmute(top_genes=Var1/nrow(cum), sample=Var2, x=value)

p <- ggplot(m, aes(x=top_genes, y=x, group=sample)) + 
  geom_line(alpha=.5) +
  xlab("Proportion of Highest Expressed Genes") +
  ylab("Proportion of Reads") + xlim(c(0,.5)) + theme_bw()
p

ggsave("Figure3_read_expenditure.pdf", p, width=5.5, height=5)
