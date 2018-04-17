bam=$1
desired_cov=$2
## Get total number of reads
tot=$(samtools idxstats $bam | cut -f3 | awk 'BEGIN {total=0} {total += $1} END {print total}')
## genome length
glen=3,137,144,693

cov=$(bc -l <<< "${tot}/${glen}")
prop=$(bc <<< "scale=2;${desired_cov}/${cov}")
echo "cov: $cov and prop: $prop"
sambamba view -f bam -t 10 --subsampling-seed=42 -s $prop -o $(basename $bam .bam).${desired_cov}X.bam $bam
