#!/bin/bash -e
#SBATCH -A               uoa00571
#SBATCH --job-name       bwa_array
#SBATCH --cpus-per-task  12
#SBATCH --time           12:00:00
#SBATCH --mem            24G
#SBATCH -o               logs/bwa/bwa_%a.out
#SBATCH -e               logs/bwa/bwa_%a.err

module purge
module load BWA/0.7.17-GCC-11.3.0
module load SAMtools/1.19-GCC-12.3.0

OUTDIR=bwa_out
mkdir -p $OUTDIR

# Modify this approporiately
BWA_INDEX=/refGenome/hg38/GRCh38_no_alt_plus_hs38d1_analysis_set/bwaIndex/GCA_000001405.15_GRCh38_no_alt_plus_hs38d1_analysis_set.fna
FILES=($(ls -1 trimmedFq/*_R1.trim.fastq.gz))

R1=${FILES[$SLURM_ARRAY_TASK_ID]}
R2=${R1%_R1.trim.fastq.gz}_R2.trim.fastq.gz
SAMPLE=`basename ${R1%_R1.trim.fastq.gz}`

bwa mem -M -Y -R "@RG\tID:$SAMPLE\tSM:$SAMPLE\tPL:Illumina" -t $SLURM_CPUS_PER_TASK $BWA_INDEX $R1 $R2 | samtools view -b -o $OUTDIR/${SAMPLE}.unsorted.bam -