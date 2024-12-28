#
# getStepLenDatFiles.R 
#
# This script is distributed 'as is'. There's no guarantee that it will work with your data or for your application.
#
# J. Alfredo Freites
# jfreites@uci.edu
#
# 12/18/24:
# First wide distribution version based on getDatTrajFilesGoodones.R
#
# From the RDS files generated with getDatTrajFilesGoodones.R select mobile trajectories and save as text files to be processed with Mathematica 
# to model individaul trajectory step lengths distributions as mixture of Rayleigh distributions (see Ly et al. eq. 4).
#

#          
# Run at the command line as
#
#         Rscript getStepLenDatFiles.R classDataFrame cutoff jfilenamesList delta dataDir workDir  
# Input: 
#
#         classDataFrame: full path to the class/treatment data frame (generated with ImmobileMobile_generate.ipynb)
#         cutoff: the minimum trajectory length used in getTrajs.R doesn't play a role in the calculation, it's just added to input/output file names 
#         jfilenamesList: full path to a text file listing JSON filenames without extension from a single experimental session 
#         delta: units of separation between positions used compute step lengths, delta=1 (default) will compute step lengths between consecutive positions, it's just added to input/output file names 
#         dataDir: path to the location of step length RDS files, it will be appended to each filename (defaults to the output of getwd())
#         workDir: where to dump the output (defaults to the output of getwd()) 
#
#
# Output:
#         A list of step matrices saved as an RDS file named paste0(outname,"-StepsNormalized-",cutof,".rds")
#
#

################################ user interface ################################################################

args<-commandArgs(trailingOnly = TRUE    )

if(length(args) < 3) {
    stop('at least three arguments needed')
    }

if(length(args) > 6) {
    stop('too many arguments')
    }

if(length(args) >= 4) {
    delta<-as.numeric(args[4])
    } else {
    delta<-1
    }

if(length(args) >= 5) {
    dataDir<-paste0(args[5],"/")
    } else {
    dataDir<-paste0(getwd(),"/")
    }

if(length(args) == 6) {
    workDir<-paste0(args[6],"/")
    } else {
    workDir<-paste0(getwd(),"/")
    }

#trajectory length cutoff only used in the output filename
cutof<-args[2]

#list of json filenames (without extension)
jfilenames<-scan(args[3],what=character())

#class/treatement data frame
classDataFrame<-args[1]





############################ end of user interface ###########################################################


#select mobile trajectories
df<-readRDS(classDataFrame)
rns<-rownames(df[df$class=="mobile",])

#common input/out name
mySufix<-paste0("-StepLengthDelta","-",delta,"-",cutof)
    
for(j in seq_along(jfilenames)){
        theFileName<-paste0(dataDir,jfilenames[j],mySufix,".rds")
  if(file.exists(theFileName)){
        mobi<-readRDS(theFileName)
        mobi<-mobi[names(mobi)%in%rns]
        mobi<-lapply(mobi,function(z)z[!is.na(z) & z>0])
        outname<-paste0(dataDir,jfilenames[j],mySufix,".dat")
        es=lapply(mobi, write, outname, append=TRUE, ncolumns=1000)
        cat(paste("processed",jfilenames[j],"\n"))
  } else {
    stop(paste(theFileName,"does not exist"))
  } 
}

    
