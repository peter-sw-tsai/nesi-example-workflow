#!/bin/bash -e

#SBATCH -A               xxxxxxxx
#SBATCH --job-name       sortbams
#SBATCH --cpus-per-task  8
#SBATCH --time           6:00:00
#SBATCH --mem            8G
#SBATCH -o               logs/sort/sort_%a.out
#SBATCH -e               logs/sort/sort_%a.err

module load SAMtools/1.19-GCC-12.3.0

FILES=($(ls -1 merged_bam/*.bam))
BAM=${FILES[$SLURM_ARRAY_TASK_ID]}

OUTDIR=sorted_bam

mkdir -p $OUTDIR

samtools sort \
-@ $SLURM_CPUS_PER_TASK \
-o ${OUTDIR}/`basename ${BAM%.bam}`.sorted.bam##idx##${OUTDIR}/`basename ${BAM%.bam}`.sorted.bam.bai \
--write-index \
$BAM