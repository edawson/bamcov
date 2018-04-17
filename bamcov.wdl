task BAM_REDUCE_COV{
    File sampleBAM
    File sampleBAMIndex
    String samplename
    Int cov
    
    runtime{
        docker : "erictdawson/svdocker"
        memory : "12 GB"
        cpu : "8"
        disks : "local-disk 1000 HDD"
    }


    command <<<
        bamcov.sh ${sampleBAM} ${cov}
    >>>

    output{
        File reduced_bam = "$(basename sampleBAM .bam).${cov}X.bam"
    }
}

workflow BAM_COV{
    File sampleBAM
    File sampleBAMIndex
    String samplename
    Int cov

    call VIZTASK{
        input:
            tumorBAM=tumorBAM,
            controlBAM=controlBAM,
            samplename=samplename,
            cov=cov
    }
}
