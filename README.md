# Example workflow
This repository contains set of slurm scripts used for processing and analysing short read whole genome sequencing dataset.
The germline analysis performed using DeepVariant v1.5.0 on the "normal" sample whereas the somatic snvs/indels are called using VarScan2.4.6
Please modify it accordingly based on the environment

*Resource allocation and account info in each slurm script needs to be modifed*

Step 1. Trimming with fastp `1_fastp_array.sl`

Step 2. Aligning against reference genome with BWA `2_bwa_array.sl`

Step 3. Create list of files each containing path to bam multple files that belong to one sample `3_makeBamList.sh`

Step 4. Merge bam files based on files created in Step 3. `4_merge_bam_array.sl`

Step 5. Sort bams by genomic coordinates `5_sortbam_array.sl`

Step 6. Remove/mark PCR duplicated using Piacrd Tools `6_rmduplicates_array.sl`

Step 7. Collect useful metrics using Picard Tools `7_CollectWgsMetrics_array.sl`

Step 8. Run Google DeepVariant `8_run_dv.sl`

Step 9. Submit VarScan2 somatic analysis on each chromosome seperately since VarScan2 itself is not parallelized `9_submit_per_chr_varscan2_job.sh`
