setwd("D:/R-scripts/readbcform")

## This function returns the variables section of BC Forms 
processFile = function(filepath) {
  con = file(filepath, "r")
  data_str = "";
  is_started = FALSE;
  while ( TRUE ) {
    line = readLines(con, n = 1)
    if ( length(line) == 0 ) {
      break
    }
	print(line)
	
	if ( startsWith( line, '</variables>')){
		is_started = FALSE
	}
	
	if(is_started){
		data_str = paste(data_str, line, sep="\n")
	}
	
    if(startsWith( line, '<variables>')) {
    	is_started = TRUE
    } 		
  }

  close(con)
  return (data_str)
}

#read a sample BC form and get the string buffer of variables section only 
fpath = "data/biological_lab_results_sputum_bc.txt";
data_str = processFile(fpath)
data_str

#read dataframe from the string buffer 
data <- read.delim(text=data_str, check.names=FALSE, stringsAsFactors=FALSE)
head(data)

#filtering required columns
columnList<-c("VARIABLE","DESCRIPTION","TYPE")
filtered_data<- data[ ,which((names(data) %in% columnList)==TRUE)]
head(filtered_data)

#write the data from sample BC form to a csv.
outpath = "data_out.csv";
write.csv(filtered_data, file = outpath, quote=FALSE, row.names=TRUE)


