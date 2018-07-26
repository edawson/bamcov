task bamRestrictTask{
    File sampleBAM
    File sampleBAMIndex
    File bedFile
    String samplename
   
    String outname = basename(sampleBAM, ".bam") + ".restrictedTo." + basename(bedFile, ".bed") + ".bam"

    runtime{
        docker : "erictdawson/svdocker"
        memory : "4 GB"
        cpu : "4"
        disks : "local-disk 1000 HDD"
        preemptible : 4
    }


    command <<<
        samtools view -L ${bedFile} -@4 -b ${sampleBAM} > ${outname}
    >>>

    output{
        File restrictedBAM = "${outname}"
    }
}

workflow bamRestrict{
    File sampleBAM
    File sampleBAMIndex
    File bedFile
    String samplename

    call bamRestrictTask{
        input:
            sampleBAM=sampleBAM,
            sampleBAMIndex=sampleBAMIndex,
            samplename=samplename,
            bedFile=bedFile
    }
}
