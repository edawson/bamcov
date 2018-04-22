task BAM_REDUCE_COV{
    File sampleBAM
    File sampleBAMIndex
    String samplename
    Int desiredCOV
    Int actualCOV
   

    String output_name = "basename(${sampleBAM}, ".bam").${desiredCOV}X.bam"
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
        File reduced_bam = "${output_name}"
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
            sampleBAM=sampleBAM,
            sampleBAMIndex=sampleBAMIndex,
            samplename=samplename,
            actualCOV=actualCOV,
            desiredCOV=desiredCOV
    }
}
