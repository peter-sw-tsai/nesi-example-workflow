#!/bin/bash -e

#SBATCH -A               xxxxxxxx
#SBATCH --job-name       wgsMetrics
#SBATCH --cpus-per-task  2
#SBATCH --time           8:00:00
#SBATCH --mem            8G
#SBATCH -o               logs/wgsMetrics/wgsMetrics_%a.out
#SBATCH -e               logs/wgsMetrics/wgsMetrics_%a.err

module purge
module load Java/20.0.2

FILES=($(ls -1 rmdup_bam/*.bam))
BAM=${FILES[$SLURM_ARRAY_TASK_ID]}

# Modify this
REF=/refGenome/hg38/GRCh38_no_alt_plus_hs38d1_analysis_set/fasta/GCA_000001405.15_GRCh38_no_alt_plus_hs38d1_analysis_set.fna
PICARD=picard.jar
OUTDIR=wgsMetrics/

mkdir -p $OUTDIR

java -jar $PICARD CollectWgsMetrics \
-I ${BAM} \
-O ${OUTDIR}/`basename ${BAM%.bam}`.wgsMetrics.txt \
-R ${REF}

