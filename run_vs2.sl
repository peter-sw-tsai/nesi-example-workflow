#!/bin/bash -e
#SBATCH -A               uoa00571
#SBATCH --cpus-per-task  1
#SBATCH --time           6:00:00
#SBATCH --mem            12G

module purge
module load SAMtools/1.16.1-GCC-11.3.0

VARSCAN2=VarScan.v2.4.6.jar
REF=/refGenome/hg38/GRCh38_no_alt_plus_hs38d1_analysis_set/fasta/GCA_000001405.15_GRCh38_no_alt_plus_hs38d1_analysis_set.fna
OUTDIR=vs2_out
TBAM=$1
NBAM=$2
CHR=$3

mkdir -p $OUTDIR

SAMPLE=`basename ${TBAM%.bam}`

samtools mpileup -r "${CHR}" -q 1 -f $REF $NBAM $TBAM | \
java -jar -Xmx12G $VARSCAN2 somatic \
--mpileup 1 \
--output-vcf 1 \
--min-var-freq 0.1 \
--p-value 1.00 \
--somatic-p-value 1.00 \
--tumor-purity 0.5 \
--min-coverage-normal 10 \
--min-coverage-tumor 10 \
--output-snp ${OUTDIR}/${SAMPLE}.${CHR}.snp.vcf \
--output-indel ${OUTDIR}/${SAMPLE}.${CHR}.indel.vcf
