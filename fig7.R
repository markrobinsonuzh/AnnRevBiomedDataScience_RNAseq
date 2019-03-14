# minor modifications to the plots from current 'rnaseqGene' workflow
plotMA(res, xlim=c(5,100000), ylim=c(-5,5))
plotDispEsts(dds, xlim=c(5,100000), ylim=c(1e-5, 1), legend=FALSE)
