#from the alignment using fastq-taxoner on PATRIC ~30K genomes

#just trying with 0.fasta (so sort of a random collection of 4gb worth of bacterial genomes)

#get all the *.sams from bacterial dir
# cd taxoner-out/
# samtools view -H -o ../header.sam ./DNA_3_ACAGTG_L007_004.1.fastq/Alignments/0.fasta.sam
# find ./ -iname 0.fasta.sam > ../all0fastalist
# for i in $(cat ../all0fastalist); do samtools view $i >> 0.merged.sam; done&
# MYFASTA="/rsgrps/bhurwitz/hurwitzlab/data/reference/taxoner_db/0.fasta"
# samtools view -@ 6 -b -T $MYFASTA -o 0.merged.bam 0.merged.sam&
# samtools rmdup 0.merged.bam dupsremoved-merged.bam 2>samtools.errors&
# samtools depth dupsremoved-merged.bam > dupsremoved.coverage 2>samtools.errors&
