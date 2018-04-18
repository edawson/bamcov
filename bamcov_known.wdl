task BAM_REDUCE_COV{
    File sampleBAM
    File sampleBAMIndex
    String samplename
    Int desiredCOV
    Int actualCOV
    
    runtime{
        docker : "erictdawson/svdocker"
        memory : "12 GB"
        cpu : "8"
        disks : "local-disk 1000 HDD"
    }


    command <<<
        bamcov_known.sh ${sampleBAM} ${desiredCOV} ${actualCOV}
    >>>

    output{
        File reduced_bam = "$(basename sampleBAM .bam).${desiredCOV}X.bam"
    }
}

workflow BAM_COV{
    File sampleBAM
    File sampleBAMIndex
    String samplename
    Int actualCOV
    Int desiredCOV

    call BAM_REDUCE_COV{
        input:
            tumorBAM=tumorBAM,
            controlBAM=controlBAM,
            samplename=samplename,
            actualCOV=actualCOV,
            desiredCOV=desiredCOV
    }
}
