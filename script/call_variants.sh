#!/bin/bash


# Step 04: Variant Calling with HaplotypeCaller

SAMPLE="SRR8707685"
BASE_DIR="$HOME/variant_calling"
REF="$BASE_DIR/ref_data/brca_ref.fa"
INPUT_BAM="$BASE_DIR/aligned_reads/${SAMPLE}_dedup.bam"
OUTPUT_VCF="$BASE_DIR/results/${SAMPLE}_raw_variants.vcf"

echo "STARTING VARIANT CALLING FOR: $SAMPLE"

# 2. RUN GATK HaplotypeCaller

gatk HaplotypeCaller \
     -R "$REF" \
     -I "$INPUT_BAM" \
     -O "$OUTPUT_VCF" \
     -L chr13 -L chr17


echo "VARIANT CALLING COMPLETE!"

echo "Output file: $OUTPUT_VCF"

# Extracting SNPs & INDELS

REF="$BASE_DIR/ref_data/brca_ref.fa"
RAW_VCF="$BASE_DIR/results/${SAMPLE}_raw_variants.vcf"
RESULTS="$BASE_DIR/results"

echo "Splitting Raw VCF into SNPs and Indels..."

gatk SelectVariants -R "$REF"  -V "$RAW_VCF"  --select-type-to-include SNP  -O "${RESULTS}/raw_snps.vcf"

gatk SelectVariants -R "$REF"  -V "$RAW_VCF"   --select-type INDEL  -O "${RESULTS}/raw_indels.vcf"


