#!/bin/bash -e

# Create a text file containing list of bams that needs to be merged for each sample.
# This is based on a tab-delimited sample.txt file (no header) that have two columns, 
# one for internal sequencing code and one for the actual sample ID.
# The bash command then uses `find` to identify the bam file and output the path to bam 
# See sample.txt

DIR=/nesi/nobackup/uoa00571/peter/rakeiora/Kinghorn_siNETs_pNETs/bwa_out

mkdir -p sample_list

while IFS=$'\t' read -r -a line
do
  echo "# working on ${line[0]}"
  find $DIR -name "*${line[0]}*" > sample_list/${line[0]}_${line[1]}.txt
done < samples.txt
