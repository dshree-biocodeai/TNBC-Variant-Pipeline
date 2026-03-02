#!/bin/bash
#--------------------------------------------------------------------------------------------------
# Script: Step 05 - Variant Filtering with GATK
#-------------------------------------------------------------------------------------------------

# 1. SET VARIABLES
SAMPLE="SRR8707685"
BASE_DIR="$HOME/variant_calling"
REF="$BASE_DIR/ref_data/brca_ref.fa"
RAW_VCF="$BASE_DIR/results/${SAMPLE}_raw_variants.vcf"
RESULTS="$BASE_DIR/results"

echo "Applying separate filters..."

# 2. FILTER SNPs (Standard GATK Hard Filters)

gatk VariantFiltration \
    -R "$REF" \
    -V "${RESULTS}/raw_snps.vcf" \
    -O "${RESULTS}/filtered_snps.vcf" \
    -filter-name "QD_filter" -filter "QD < 2.0" \
    -filter-name "FS_filter" -filter "FS > 60.0" \
    -filter-name "MQ_filter" -filter "MQ < 40.0" \
    -filter-name "SOR_filter" -filter "SOR > 4.0" \
    -filter-name "MQRankSum_filter" -filter "MQRankSum < -12.5" \
    -filter-name "ReadPosRankSum_filter" -filter "ReadPosRankSum < -8.0" \
    -genotype-filter-expression "DP < 10" \
    -genotype-filter-name "DP_filter" \
    -genotype-filter-expression "GQ < 10" \
    -genotype-filter-name "GQ_filter"
    --filter-name "snp_filter"

# 3. FILTER INDELs
gatk VariantFiltration \
    -R "$REF" \
    -V "${RESULTS}/raw_indels.vcf" \
    -O "${RESULTS}/filtered_indels.vcf" \
    -filter-name "QD_filter" -filter "QD < 2.0" \
    -filter-name "FS_filter" -filter "FS > 200.0" \
    -filter-name "SOR_filter" -filter "SOR > 10.0" \
    -genotype-filter-expression "DP < 10" \
    -genotype-filter-name "DP_filter" \
    -genotype-filter-expression "GQ < 10" \
    -genotype-filter-name "GQ_filter"
    --filter-name "indel_filter"

echo "Done! Filtering complete for SNPs and Indels."

echo "Total SNPs:"
grep -v "^#" ../results/filtered_snps.vcf | wc -l

echo "Total INDELs:"
grep -v "^#" ../results/filtered_indels.vcf | wc -l

# Select Variants that PASS filters
gatk SelectVariants \
        --exclude-filtered \
        -V "${RESULTS}/filtered_snps.vcf" \
        -O "${RESULTS}/analyzed_snps.vcf"


gatk SelectVariants \
        --exclude-filtered \
        -V "${RESULTS}/filtered_indels.vcf" \
        -O "${RESULTS}/analyzed_indels.vcf"

echo "PASS Filtering analysis DONE!"












