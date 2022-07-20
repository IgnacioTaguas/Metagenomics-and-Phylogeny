# Metagenomics-project
In-depth genomic exploration of the ecosystem of a hot spring located in Iceland, in which episodes of high temperature (close to 90º) occur coinciding with regular activities in a nearby volcano.

The analysis has three steps:
  - Metagenomics: the results from shotgun sequencing (produced by Illuma paired-end sequencing) are in FASTQ format; the quality of the reads is analyzed, and the relative abundance of each organism under each condition calculated.
  - Genomics and variant calling: high-quality reads in FASTA format from the organism of interest are analyzed. They are aligned to the reference genome to do the copy number variation and the variant calling analyses. The software IGV is used. Finally, a differential expression analysis is carried out.
  - Phylogeny: phylogenetic trees are constructed using iqtree, and a functional prediction is done.



This directory also has a PDF (Phylogeny) written in spanish with a detailed pipeline of a different project, related with the subject, consisting on the phylogenetic analysis of viral genomes comparing the maximum likelihood and bayesian estimation methods. The programs used were:
  - MEGA: to assess genetic distances.
  - jModelTest, PhyML and FigTree: to compute a phylogenetic tree using maximum likelihood.
  - BEAUti2, BEAST2, Tracer, TreeAnnotator: to compute a phylogenetic tree using bayesian statistic.
  - FigTree: to plot the phylogenetic trees.
