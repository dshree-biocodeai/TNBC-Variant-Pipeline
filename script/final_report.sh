#!/bin/bash

# 1. Create a final report folder
mkdir -p ~/variant_calling/final_report

# 2. Extract the high-impact summary to a readable text file
grep -Ei "NONSENSE|FRAME_SHIFT" ~/variant_calling/results/SRR8707685_annotated.vcf | \
sed 's/.*FUNCOTATION=\[//;s/|.*//' | awk '{print "Gene:", $1, "| Pos:", $2}' > ~/variant_calling/final_report/high_impact_variants.txt

echo "Final analysis complete! Summary saved in final_report/high_impact_variants.txt"
