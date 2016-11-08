#bacterial RNA coverage
#to the "golden standard" 1,944 genomes
#probably the closest comparison to mouse-RNA-coverage

#commands I ran on the supercomputer

#merge all the samples
#samtools merge -@ 6 merged.bam -b allbams

#remove PCR duplicates
#samtools rmdup merged.bam dupsremoved-merged.bam

#calculate the coverage
#samtools depth dupsremoved-merged.bam > dupsremoved.coverage

setwd("~/allbact-out-coverage/")
system("cut -f3 dupsremoved.coverage > justcov")
system("egrep -v 0 justcov > justcov_nozeroes")
pw <- scan("justcov_nozeroes")
summary(pw)

vsj=scan("justcov")

#length of coverage
length(vsj[vsj!=0])/length(vsj)
#99%, noice!
