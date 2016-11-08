#coverage from the bacterial co-assembly using megahit

setwd("~/megahit_output_dedup")

system("cut -f2 covstats.txt > just_avg_fold")

justAvgFold <- scan("just_avg_fold", skip = 1)

summary(justAvgFold)

#a whopping 11X! this is why we can't do SNP

