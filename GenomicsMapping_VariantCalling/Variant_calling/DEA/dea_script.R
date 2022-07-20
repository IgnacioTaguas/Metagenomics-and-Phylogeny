library (DESeq2)
library(ggplot2)

setwd ("C:/Users/Nacho/Desktop/genomics_project/2_genomics_mapping_variantCalling/Variant_calling/DEA")

#We load the data
counts = read.table("total_counts.txt", quote="\"", comment.char="", row.names=1)
colnames = c("Normal_02", "Normal_01", "High_02", "High_01")
colnames(counts)=colnames
my.design <- data.frame (row.names=colnames(counts), condition = c("Normal", "Normal", "High", "High"))

#As input, we have a matrix of read counts, so we will used the DESeqDataSetFromMatrix function
###This function requires the counts matrix, the information about the sampels as a data frame, and the design formula
#Using this, we can construct a DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData = counts, 
                              colData = my.design, 
                              design = ~ condition)

#Pre-filtering: we remove rows with no/very little reads
###We remove rows with 0 or 1 reads
dds <- dds[rowSums(counts(dds)) > 1, ] #From 1503 to 1496

#We tell the DESeq2 functions which leel we want to compare against
dds$condition <- factor(dds$condition, levels = c("Normal", "High"))


dds <- DESeq(dds)
res <- results(dds)

n <- sum(res$padj < 0.1, na.rm=T) #4 genes with adjusted p-values < 0.1

#2 are up regulated and 2 are down regulated
summary(res)

resOrdered <- res[order(res$padj),]
best <- head (resOrdered, n)

res_df <- data.frame (res$padj)

ggplot(data=res_df, aes(x=res.padj)) +
  geom_histogram(binwidth=.1,
                 color = "black", fill = "steelblue") + 
  theme_minimal() +
  labs(title="Padj values",
       x="BH adjusted p-values",
       y="Frequency") +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        axis.title.x = element_text (size = 14, face = "bold", vjust = 0),
        axis.title.y = element_text (size = 14, face = "bold", vjust = 1.5),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.ticks = element_line(colour = "black", size=1),
        panel.border = element_rect(colour = "black", fill=NA, size=1)) +
  scale_x_continuous(breaks = seq(0, 1, by = .1), expand = c(0,0)) +
  coord_cartesian(xlim = c(0,1), ylim=c(0,80)) +
  scale_y_continuous(breaks=seq(0,80, by = 4), expand = c(0,0))