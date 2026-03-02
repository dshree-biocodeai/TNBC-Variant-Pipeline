#!/bin/bash

# ------------------------------------------------------------------
# Script: Step 02 - BWA-MEM Alignment
# Purpose: Map TNBC WES reads to BRCA Targeted Reference
# ------------------------------------------------------------------

# 1. DEFINE VARIABLES
SAMPLE="SRR8707685"
REF="../ref_data/brca_ref.fa"
R1="../reads_data/${SAMPLE}_1.fastq.gz"
R2="../reads_data/${SAMPLE}_2.fastq.gz"
RESULTS="../results"

echo "STARTING ALIGNMENT FOR SAMPLE: $SAMPLE"

# 2. RUN BWA-MEM & CONVERT TO BAM ON THE FLY
# -t 4: Uses 4 cores (Adjust based on your laptop)
# | samtools view: Converts output to Binary (BAM)
# | samtools sort: Sorts reads by genomic coordinate

echo "Aligning, Converting and Sorting..."

bwa mem -t 4 \
 -R "@RD\tID:${SAMPLE}\tSM:${SAMPLE}\tPL:ILLUMINA" \
 "$REF" "$R1" "$R2" | \
samtools view -Sb - | \
samtools sort -o "${RESULTS}/${SAMPLE}_sorted.bam"

# 3. Indexing the sorted BAM(creates a .bai file)
echo "Indexing the BAM file..."
samtools index ${RESULTS}/${SAMPLE}_sorted.bam

echo "ALIGNMENT COMPLETE"
echo "File created: ${RESULTS/${SAMPLE}_sorted.bam}"


#--------------------------------------------------------------------------------------
# Script: Step 03 - GATK MarkDuplicates
# 1. SET VARIABLES
#--------------------------------------------------------------------------------------

# 1. Defining Variables
SAMPLE="SRR8707685"
INPUT_BAM="../results/${SAMPLE}_sorted.bam"
OUTPUT_BAM="../results/${SAMPLE}_dedup.bam"
METRICS="../results/${SAMPLE}_dup_metrics.txt"


echo "STARTING MARK DUPLICATES FOR: $SAMPLE"


# 2. RUN GATK MARKDUPLICATES
# -I: Input sorted BAM
# -O: Output BAM with duplicate flags
# -M: A text file showing the % of duplication (Great for your report!)
gatk MarkDuplicates \
    -I $INPUT_BAM \
    -O $OUTPUT_BAM \
   -M $METRICS \
   --CREATE_INDEX true

echo "MARK DUPLICATES COMPLETE"
echo "Metrics saved to: $METRICS"
echo "Clean BAM created: $OUTPUT_BAM"
