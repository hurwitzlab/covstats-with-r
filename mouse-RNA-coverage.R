setwd("~/covstats-with-r/")

#commands I ran on the supercomputer

#merge all the samples
#samtools merge -@ 6 -b ./allbams merged.bam

#remove PCR duplicates
#samtools rmdup merged.bam dupsremoved-merged.bam

#calculate the coverage
#samtools depth dupsremoved-merged.bam > dupsremoved.coverage

#split up by chromosome
#gawk '/^[0-9]/ {print > $1".coverage"}' ./dupsremoved.coverage
#gawk '/^[MTXY]/ {print > $1".coverage"}' ./dupsremoved.coverage

setwd("~/mouse-coverage")

mouse.chr1 <- read.table("1.coverage", header=FALSE, sep="\t", na.strings="NA", dec=".", strip.white=TRUE, colClasses = c("integer","integer","integer"),nrows = 1e9, col.names = c("Chr","locus","depth"))

#let's zoom in, shall we?
attach(mouse.chr1)
mouse.chr1<-mouse.chr1[(locus < 5e7),]
mouse.smaller<-mouse.chr1[(locus < 3e7) & (locus > 2e7),]

#plot(mouse.chr1$locus, mouse.chr1$depth)

library(lattice, pos=10)

xyplot(depth ~ locus, type="p", pch=16, auto.key=list(border=TRUE), par.settings=simpleTheme(pch=16), scales=list(x=list(relation='same'), y=list(relation='same')), data=mouse.smaller, main="depth by locus - Chr1")

#let's do chr9 since that's where SMAD3 is
mouse.chr9 <- read.table("9.coverage", header=FALSE, sep="\t", na.strings="NA", dec=".", strip.white=TRUE, colClasses = c("integer","integer","integer"),nrows = 1e9, col.names = c("Chr","locus","depth"), comment.char = "")

xyplot(depth ~ locus, type="p", pch=16, auto.key=list(border=TRUE), par.settings=simpleTheme(pch=16), scales=list(x=list(relation='same'), y=list(relation='same')), data=mouse.chr9, main="depth by locus - Chr9")

#EVERYTIONG!
#cat *.coverage > allTogetherNow
#cut -f3 allTogetherNow > justcov
pp <- scan("justcov")
#summary including zeros
summary(pp)

pp[pp!=0]->pq

#summary not including zeros
#so this is more like protein coding sequence
summary(pq)
#a whopping 3X!

#length of coverage
length(pp[pp!=0])/length(pp)
#eesh, 8.3%

#Used this as a guide: https://www.biostars.org/p/104063/

#In case page gets deleted####
# Here is a step by step guide to the problem/question.
# Step #1) First identify the depth at each locus from a bam file.
#
# I have found samtools depth option more useful in this regard, when coverage at each locus is desired.
#
# samtools depth deduped_MA605.bam > deduped_MA605.coverage
#
# The output file 'deduped_MA605.coverage' file will have 3 columns (Chr#, position and depth at that position) like below.
# Step #2) Now, select the coverage (depth) by locus for each chromosome and/or regions
#
# We can use the coverage file to plot it in R. But, the file is so large that it will suck up almost all the memory. It better to split the coverage by chromosome (or region of the chromosome if required).
#
# To select the coverage for a particular chromosome (Chr#1 in my case)
#
#                                                     awk '$1 == 1 {print $0}' deduped_MA605.coverage > chr1_MA605.coverage
#
#                                                     To select coverage from chr #2
#
#                                                     awk '$1 == 2 {print $0}' deduped_MA605.coverage > chr2_MA605.coverage
#
#                                                     If the chrosomosome has string characters it can be adjusted as
#
#                                                     awk '$1 == "chr2" {print $0}' deduped_MA605.coverage > chr2_MA605.coverage
#
#                                                     Step #3) To plot the data in R this coverage file will need to be imported and the headers need to be added.
#
#                                                     MA605.chr2 <- read.table("/media/everestial007/SeagateBackup4.0TB/New_Alignment_Set/05-B-deDupedReads-forScanIndel/chr2_MA605.coverage", header=FALSE, sep="\t", na.strings="NA", dec=".", strip.white=TRUE)
#
#                                                     Note: The header of the column are automatically set as V1, V2 and V3.
# To rename the headers
#
# library(reshape) # loads the library to rename the column names
#
# MA605.chr2<-rename(MA605.chr2,c(V1="Chr", V2="locus", V3="depth")) # renames the header
#
# Now, plot the coverage by depth:
#
#   plot(MA605.chr2$locus, MA605.chr2$depth)
#
# to get the wider/cleaner view of the plot use
#
# library(lattice, pos=10) xyplot(depth ~ locus, type="p", pch=16, auto.key=list(border=TRUE), par.settings=simpleTheme(pch=16), scales=list(x=list(relation='same'), y=list(relation='same')), data=MA605.chr2, main="depth by locus - Chr2 (Sample MA605)")
