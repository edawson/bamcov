bam=$1
desired_cov=$2
## Get total number of reads
tot=$(samtools idxstats $bam | cut -f3 | awk 'BEGIN {total=0} {total += $1} END {print total}')
## genome length
#glen=3137144693
glen=$3

cov=( $(bc -l <<< "scale=5;${tot}/${glen}") )
prop=( $(bc -l <<< "scale=2;${desired_cov}/${cov}") )
echo "cov: $cov and prop: $prop"
sambamba view -f bam -t 10 --subsampling-seed=42 -s $prop -o $(basename $bam .bam).${desired_cov}X.bam $bam
