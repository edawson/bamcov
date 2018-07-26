task bamRestrictTask{
    File sampleVCF
    File sampleVCFIndex
    File bedFile
    String samplename
   
    String outname = basename(sampleVCF, ".vcf.gz") + ".restricted.vcf"

    runtime{
        docker : "erictdawson/svdocker"
        memory : "3 GB"
        cpu : "1"
        disks : "local-disk 100 HDD"
        preemptible : 4
    }


    command <<<
        bedtools intersect -sorted -header -wa -a ${sampleVCF} -b ${bedFile} > ${outname} && 
        bgzip ${outname} && \
        tabix ${outname}.gz
    >>>

    output{
        File restrictedGVCF = "${outname}.gz"
        File restrictedGVCFIndex = "${outname}.gz.tbi"
    }
}

workflow vcfRestrict{
    File sampleVCF
    File sampleVCFIndex
    File bedFile
    String samplename

    call bamRestrictTask{
        input:
            sampleVCF=sampleVCF,
            sampleVCFIndex=sampleVCFIndex,
            samplename=samplename,
            bedFile=bedFile
    }
}
