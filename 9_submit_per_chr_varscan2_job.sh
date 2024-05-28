#!/bin/bash

# Submit one job per chromosome

# Modify "tumour.bam" and "normal.bam" approporiately

for CHR in chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX chrY
do
    sbatch \
    run_vs2.sl \
    tumour.bam \
    normal.bam \
    ${CHR}
done

# Concatenate vcf for snp

ls -1v vs2_out/tumour.chr*.snp.vcf.gz > tumour.snp.txt
bcftools concat -f tumour.txt -o tumour.vs2.snp.vcf.gz -Oz
tabix -p vcf tumour.vs2.snp.vcf.gz

# Concatenate vcf for indel

ls -1v tumour.chr*.indel.vcf.gz > tumour.indel.txt
bcftools concat -f tumour.indel.txt -o tumour.vs2.indel.vcf.gz -Oz
tabix -p vcf tumour.vs2.indel.vcf.gz
