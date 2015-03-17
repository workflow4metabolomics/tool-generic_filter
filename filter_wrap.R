#!/usr/bin/Rscript --vanilla --slave --no-site-file

################################################################################################
# WRAPPER FOR filter_script.R (GENERIC FILTERS)                                                #
#                                                                                              #
# Author: Melanie PETERA based on Marion LANDI's filters' wrapper                              #
# User: Galaxy                                                                                 #
# Original data: used with filter_script.R                                                     #
# Starting date: 04-09-2014                                                                    #
# V-1: Restriction of old filter wrapper to Filter according to factors                        #
# V-1.1: Modification to allow the choice of meta-data table for filtering                     #
# V-2: Addition of numerical filter                                                            #
#                                                                                              #
#                                                                                              #
# Input files: dataMatrix.txt ; sampleMetadata.txt ; variableMetadata.txt                      #
# Output files: dataMatrix.txt ; sampleMetadata.txt ; variableMetadata.txt                     #
#                                                                                              #
################################################################################################


library(batch) #necessary for parseCommandArgs function
args = parseCommandArgs(evaluate=FALSE) #interpretation of arguments given in command line as an R list of objects

source_local <- function(...){
	argv <- commandArgs(trailingOnly = FALSE)
	base_dir <- dirname(substring(argv[grep("--file=", argv)], 8))
	for(i in 1:length(list(...))){source(paste(base_dir, list(...)[[i]], sep="/"))}
}

source_local("filter_script.R","RcheckLibrary.R")


if(length(args) < 8){ stop("NOT enough argument !!!") }

list_num <- NULL
if(!is.null(args$parm_col)){
	for( i in which(names(args)=="num_file") ){
		if(args[[i+2]] %in% c("lower","upper")){
		  list_num <- c(list_num, list(c(args[[i]], args[[i+1]], args[[i+2]],args[[i+3]])))
		}
		if(args[[i+2]] %in% c("between","extremity")){
		  list_num <- c(list_num, list(c(args[[i]], args[[i+1]], args[[i+2]],args[[i+3]],args[[i+4]])))
		}
	}
}	

list_fact <- NULL
if(!is.null(args$factor_col)){
	for( i in which(names(args)=="qual_file") ){
		list_fact <- c(list_fact, list(c(args[[i+1]], args[[i+2]], args[[i]])))
	}
}	

filters(args$dataMatrix_in, args$sampleMetadata_in, args$variableMetadata_in,
        args$Numeric, list_num, args$Factors, list_fact,
        args$dataMatrix_out, args$sampleMetadata_out, args$variableMetadata_out)

#filters(ion.file.in, meta.samp.file.in, meta.ion.file.in,
#        NUM, ls.num, FACT, ls.fact,
#        ion.file.out, meta.samp.file.out, meta.ion.file.out)

#delete the parameters to avoid the passage to the next tool in .RData image
rm(args)
