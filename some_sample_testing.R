setwd("D:/R-scripts/readbcform/data")

#These are some samples to test dataframe from string buffer 
sample_data_str = "flim,flam\n1.2,2.2\n77.1,3.14";
sample_data <- read.csv(text=sample_data_str);
sample_data
sample_data2 <- read.delim(text=sample_data_str, check.names=FALSE, stringsAsFactors=FALSE)
sample_data2

sample_data_str = "flim\tflam\n1.2\t2.2\n77.1\t3.14";
sample_data3 <- read.delim(text=sample_data_str, check.names=FALSE, stringsAsFactors=FALSE)
sample_data3

#now checking whether write.csv has been written correctly from string buffer  
outpath = "test_out.csv";
write.csv(sample_data3, file = outpath, quote=FALSE, row.names=TRUE)

#checking startsWith function 
startsWith( 'Testing', 'Test')

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
fpath = "biological_lab_results_sputum_bc.txt";
data_str = processFile(fpath)
data_str

#read dataframe from the string buffer 
sample_data4 <- read.delim(text=data_str, check.names=FALSE, stringsAsFactors=FALSE)
head(sample_data4)

#write the data from sample BC form to a csv.
outpath = "test_out2.csv";
write.csv(sample_data4, file = outpath, quote=FALSE, row.names=TRUE)


