

# Navigate to reference folder
cd ~/variant_calling/ref_data

# Download Chromosome 13 and 17 from UCSC (GRCh38)
echo "Downloading Chromosomes 13 and 17..."
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/chr13.fa.gz
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/chr17.fa.gz

# Decompress the files
echo "Decompressing files..."
gunzip chr13.fa.gz
gunzip chr17.fa.gz

# Combine them into a single reference file
# This is a 'best practice' to avoid running alignment 24 separate times
cat chr13.fa chr17.fa > brca_ref.fa

# Indexing for the Pipeline
# A. Index for BWA (Alignment) 
bwa index brca_ref.fa

# B. Index for SAMtools (Viewing) 
samtools faidx brca_ref.fa

# C. Create Dictionary for GATK (Variant Calling)
gatk CreateSequenceDictionary -R brca_ref.fa
