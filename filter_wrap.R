#!/usr/bin/Rscript --vanilla --slave --no-site-file

################################################################################################
# WRAPPER FOR filter_script.R (GENERIC FILTERS)                                                #
#                                                                                              #
# Author: Melanie PETERA based on Marion LANDI's filters' wrapper                              #
# User: Galaxy                                                                                 #
# Original data: used with filter_script.R                                                     #
# Starting date: 04-09-2014                                                                    #
# V-1: Restriction of old filter wrapper to Filter according to factors                        #
#                                                                                              #
#                                                                                              #
# Input files: dataMatrix.txt ; sampleMetadata.txt ; variableMetadata.txt                      #
# Output files: dataMatrix.txt ; sampleMetadata.txt ; variableMetadata.txt                     #
#                                                                                              #
################################################################################################


library(batch) #necessary for parseCommandArgs function
args = parseCommandArgs(evaluate=FALSE) #interpretation of arguments given in command line as an R list of objects

source_local <- function(fname){
	argv <- commandArgs(trailingOnly = FALSE)
	base_dir <- dirname(substring(argv[grep("--file=", argv)], 8))
	source(paste(base_dir, fname, sep="/"))
}
#Import the different functions
source_local("filter_script.R")
#source("/usr/local/share/R/filter_script.R")


if(length(args) < 8){ stop("NOT enough argument !!!") }

list_fact <- NULL
if(!is.null(args$factor_col)){
	for( i in which(names(args)=="factor_col") ){
		list_fact <- c(list_fact, list(c(args[[i]], args[[i+1]])))
	}
}	

filters(args$dataMatrix_in, args$sampleMetadata_in, args$variableMetadata_in,
        args$Factors, list_fact,
        args$dataMatrix_out, args$sampleMetadata_out, args$variableMetadata_out)

#filters(ion.file.in, meta.samp.file.in, meta.ion.file.in,
#        FACT, ls.fact,
#        ion.file.out, meta.samp.file.out, meta.ion.file.out)

#delete the parameters to avoid the passage to the next tool in .RData image
rm(args)
