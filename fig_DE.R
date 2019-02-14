


library(airway)
library(DESeq2)
data("airway")
se <- airway
se$dex <- relevel(se$dex, "untrt")
dds <- DESeqDataSet(se, design = ~ cell + dex)
dds <- dds[rowSums(counts(dds) >= 5) >= 4,]
dds <- DESeq(dds, quiet=TRUE)

pdf("Figure7_figDE.pdf", width = 9, height=4.5)
par(mfrow=c(1,2))
plotDispEsts(dds, ylim=c(1e-5,10))
mtext("A", side=3, adj=-.05, padj=-.1, cex=2.5)
plotMA(dds)
mtext("B", side=3, adj=-.05, padj=-.1, cex=2.5)
dev.off()



