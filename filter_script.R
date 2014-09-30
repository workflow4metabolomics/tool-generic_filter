################################################################################################
# GENERIC FILTERS                                                                              #
#                                                                                              #
# User: Galaxy                                                                                 #
# Starting date: 03-09-2014                                                                    #
# V-1.0: Restriction of old filter script to Filter according to factors                       #
#                                                                                              #
#                                                                                              #
# Input files: dataMatrix ; sampleMetadata ; variableMetadata                                  #
# Output files: dataMatrix ; sampleMetadata ; variableMetadata                                 #
#                                                                                              #
################################################################################################

# Parameters (for dev)
if(FALSE){
  
  ion.file.in <- "test/ressources/inputs/ex_data_IONS.txt"  #tab file
  meta.samp.file.in <- "test/ressources/inputs/ex_data_PROTOCOLE1.txt"  #tab file
  meta.ion.file.in <- "test/ressources/inputs/ex_data_METAION.txt"  #tab file
  
  ion.file.out <- "test/ressources/outputs/ex_data_IONS_fl.txt"  #tab file
  meta.samp.file.out <- "test/ressources/outputs/ex_data_PROTOCOLE1_fl.txt"  #tab file
  meta.ion.file.out <- "test/ressources/outputs/ex_data_METAION_fl.txt"  #tab file
  
  FACT <- FALSE ; if(FACT){ls.fact <- list(c("3","A"),c("6","s1"))}else{ls.fact <- NULL}
  
}

filters <- function(ion.file.in, meta.samp.file.in, meta.ion.file.in,
                    FACT, ls.fact,
                    ion.file.out, meta.samp.file.out, meta.ion.file.out){
  # This function allows to filter variables and samples according to factors or numerical values. 
  # It needs 3 datasets: the data matrix, the variables' metadata, the samples' metadata. 
  # It generates 3 new datasets corresponding to the 3 inputs filtered. 
  #
  # Parameters:
  # - xxx.in: input files' access
  # - xxx.out: output files' access
  # - FACT: filter according to factors yes/no
  # | > ls.fact: factors' list for filter
  
  
# Input --------------------------------------------

ion.data <- read.table(ion.file.in,sep="\t",header=TRUE)
meta.samp.data <- read.table(meta.samp.file.in,sep="\t",header=TRUE)
meta.ion.data <- read.table(meta.ion.file.in,sep="\t",header=TRUE)

# Error vector
err.stock <- "\n"


# Function 1: Filter according to factors ---------
# Allows to delete all elements corresponding to selected value of designated factor.
if(FACT){

  # For each factor to filter
  for(i in 1:length(ls.fact)){
    
    # Checking the columns and factors variables
    numcol <- as.numeric(ls.fact[[i]][1])
    if(!(numcol%in%(1:ncol(meta.samp.data)))) {
    err.stock <- c(err.stock,"\n-------",
                   "\nWarning: no column ",ls.fact[[i]][1]," detected in Sample meta-data !",
                   "\nFiltering impossible for this factor.\n-------\n") 
    }else{
    if(!(ls.fact[[i]][2]%in%levels(as.factor(meta.samp.data[,numcol])))){
      err.stock <- c(err.stock,"\n-------",
                     "\nWarning: no ",ls.fact[[i]][2]," level detected in column ",numcol,
                     " (sample meta-data) !\nFiltering impossible for this factor.\n-------\n")
    }else{
      
    # Filtering
    if(length(which(meta.samp.data[,numcol]==ls.fact[[i]][2]))!=0){
      meta.samp.data <- meta.samp.data[-c(which(meta.samp.data[,numcol]==ls.fact[[i]][2])),]
      ion.data <- ion.data[,c(1,which(colnames(ion.data)%in%meta.samp.data[,1]))]
    }
  }}}

} # end if(FACT)



# Output -------------------------------------------

# Error checking
if(length(err.stock)>1){
  stop(err.stock)
}else{

write.table(ion.data, ion.file.out, sep="\t", row.names=FALSE, quote=FALSE)
write.table(meta.samp.data, meta.samp.file.out, sep="\t", row.names=FALSE, quote=FALSE)
write.table(meta.ion.data, meta.ion.file.out, sep="\t", row.names=FALSE, quote=FALSE)

}


} # end of filters function


# Typical function call
#filters(ion.file.in, meta.samp.file.in, meta.ion.file.in, 
#        FACT, ls.fact,
#        ion.file.out, meta.samp.file.out, meta.ion.file.out)

