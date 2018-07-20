task BAM_REDUCE_COV{
    File sampleBAM
    File sampleBAMIndex
    File bedFile
    String samplename
   
    String outname = basename(sampleBAM, ".bam") + ".restrictedTo." + bedFile + ".bam"

    runtime{
        docker : "erictdawson/svdocker"
        memory : "12 GB"
        cpu : "1"
        disks : "local-disk 1000 HDD"
    }


    command <<<
        samtools view -L ${bedFile} -@4 -b ${sampleBAM} > ${outname}
    >>>

    output{
        File restrictedBAM = "${outname}"
    }
}

workflow BAM_COV{
    File sampleBAM
    File sampleBAMIndex
    File bedFile
    String samplename

    call BAM_REDUCE_COV{
        input:
            sampleBAM=sampleBAM,
            sampleBAMIndex=sampleBAMIndex,
            samplename=samplename,
            bedFile=bedFile
    }
}
