# TNBC-Variant-Pipeline: End-to-end GATK-based workflow for identifying clinically actionable variants in Triple-Negative Breast Cancer (TNBC).

This repository implements a reproducible precision oncology pipeline following GATK Best Practices to analyze raw sequencing data from a Triple-Negative Breast Cancer (TNBC) tumor sample SRR8707685, Fudan University TNBC cohort.
The objective of this project is to demonstrate how raw next-generation sequencing (NGS) data can be processed through alignment, quality recalibration, somatic variant calling, and functional annotation to identify high-impact mutations relevant to targeted therapy. This project is designed as a computational demonstration of a tumor-only somatic variant calling workflow and does not constitute a clinical diagnostic analysis.

Biological Question: Can we identify clinically actionable mutations in a TNBC tumor sample that may inform targeted therapy strategies? 
Triple-Negative Breast Cancer is frequently associated with deficiencies in the Homologous Recombination (HR) DNA repair pathway, particularly involving BRCA1/2 alterations. Identifying high-impact variants in these genes can have therapeutic implications.

Selected sample SRR8707685 from the Fudan University TNBC cohort (SRP157974). This sample represents Triple-Negative Breast Cancer, a subtype frequently associated with deficiencies in the Homologous Recombination (HR) DNA repair pathway, specifically involving BRCA1/2 mutations.

## Tech Stack & Standards
* Reference Genome: GRCh38 (hg38)- Chromosome 13 & 17
* Alignment: BWA-MEM
* Data Cleanup: GATK4 (MarkDuplicates, VariantFiltration, SelectVariants)
* Variant Calling: GATK HaplotypeCaller
* Annotation: GATK Funcotator (ClinVar, Gencode)

📁 Repository Structure
scripts/              # Pipeline execution scripts
env.yml               # Reproducible Conda environment
results_preview.txt   # Subset of annotated VCF
final_report      # Summary of findings and clinical interpretations.

📊 Key Findings

The pipeline identified multiple high-impact coding variants, including nonsense and frameshift mutations that are likely to disrupt protein function.

Example High-Impact Variants:-
| Gene       | Mutation Type | Predicted Effect                |
| ---------- | ------------- | ------------------------------- |
| **PABPC3** | Frameshift    | Loss of normal protein function |
| **ATP12A** | Nonsense      | Premature stop codon            |
| **MRPL57** | Frameshift    | Truncated mitochondrial protein |

High-impact variants were prioritized based on:
- Functional consequence (frameshift, nonsense)
- Read depth and variant allele fraction
- Annotation from ClinVar / cancer databases (via Funcotator)
