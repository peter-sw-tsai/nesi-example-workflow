#!/bin/bash -e

#SBATCH -A               xxxxxxxx
#SBATCH --job-name       rmdup
#SBATCH --cpus-per-task  2
#SBATCH --time           12:00:00
#SBATCH --mem            24G
#SBATCH -o               logs/rmdup/rmdup_%a.out
#SBATCH -e               logs/rmdup/rmdup_%a.err

module purge
module load Java/20.0.2

FILES=($(ls -1 sorted_bam/*.bam))
BAM=${FILES[$SLURM_ARRAY_TASK_ID]}

PICARD=/nesi/project/uoa00571/peter/rakeiora/KinghornAnalysis/picard.jar
OUTDIR=rmdup_bam

mkdir -p $OUTDIR

java -jar $PICARD MarkDuplicates \
-I $BAM \
-M ${OUTDIR}/`basename ${BAM%.bam}`.rmdup.metrics \
-O ${OUTDIR}/`basename ${BAM%.bam}`.rmdup.bam \
--CREATE_INDEX TRUE \
--TMP_DIR /tmp/$SLURM_JOB_ID # Modify this approporiately
