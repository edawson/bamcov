bam=$1
desired_cov=$2

cov=$3
prop=( $(bc -l <<< "scale=2;${desired_cov}/${cov}") )
echo "cov: $cov and prop: $prop"
sambamba view -f bam -t 10 --subsampling-seed=42 -s $prop -o $(basename $bam .bam).${desired_cov}X.bam $bam
