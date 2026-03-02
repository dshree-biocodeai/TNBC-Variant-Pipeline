#!/bin/bash
#--------------------------------------------------------------------------------------------------
# Script: Step 05 - Variant Annotation  with GATK Funcotator
#-------------------------------------------------------------------------------------------------

# MERGING THE FINAL ANALYZED VCF FILES

# 1. SET VARIABLES
BASE_DIR="$HOME/variant_calling"
RESULTS="$BASE_DIR/results"

# 2. Merging into a single VCF file
gatk MergeVcfs \
   -I "${RESULTS}/analyzed_snps.vcf" \
   -I "${RESULTS}/analyzed_indels.vcf" \
   -O "${RESULTS}/SRR8707685_final_merged.vcf"

echo "Merged VCF file created!"

# VARIANT ANNOTATION

# Downloading the data sources
gatk FuncotatorDataSourceDownloader \
   --germline \
   --hg38 \
   --validate-integrity \
   --extract-after-download \
   -O ~/variant_calling/ref_data/funcotator_dataSources

#-------------------------------------------------------------------------------------------------
# ANNOTATING VARIANTS WITH Funcotator
#-------------------------------------------------------------------------------------------------

# Setting Variables
SAMPLE="SRR8707685"
BASE_DIR="$HOME/variant_calling"
REF="$BASE_DIR/ref_data/brca_ref.fa"
INPUT_VCF="$BASE_DIR/results/${SAMPLE}_final_merged.vcf"
OUTPUT_VCF="$BASE_DIR/results/${SAMPLE}_annotated.vcf"

DATA_SOURCES="/home/dhk_2203/variant_calling/ref_data/funcotator_dataSources.v1.8.hg38.20230908g"
echo "Data sources found at: $DATA_SOURCES"

echo "Running GATK Funcotator..."

# 2. RUN FUNCOTATOR

#gatk Funcotator \
   -R "$REF" \
   -V "$INPUT_VCF" \
   -O "$OUTPUT_VCF" \
   --output-file-format VCF \
   --data-sources-path "$DATA_SOURCES" \
   --ref-version hg38

echo "Merged VCF file Annotated!"

#INPUT_VCF="$BASE_DIR/results/analyzed_snps.vcf"
#OUTPUT_VCF="$BASE_DIR/results/snps_funcotated.vcf"

gatk Funcotator \
   -R "$REF" \
   -V "$INPUT_VCF" \
    -O "$OUTPUT_VCF" \
    --output-file-format VCF \
    --data-sources-path "$DATA_SOURCES" \
    --ref-version hg38

echo "Analyzed SNPs VCF file Annotated!"

#INPUT_VCF="$BASE_DIR/results/analyzed_indels.vcf"
#OUTPUT_VCF="$BASE_DIR/results/indels_funcotated.vcf"

gatk Funcotator \
   -R "$REF" \
    -V "$INPUT_VCF" \
    -O "$OUTPUT_VCF" \
    --output-file-format VCF \
    --data-sources-path "$DATA_SOURCES" \
   --ref-version hg38

echo "Analyzed Indels VCF file Annotated!"


