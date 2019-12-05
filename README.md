# Common-CNVs
Find recurrent copy number variants from Control-FREEC output

## Getting Started
You should have a .txt file for each sample containing CNV information

Place all these files in your working directory

### Importing Control-FREEC CNV files

Import all text files and create column with file name:

  ```
  file_list <- list.files(pattern=".*.txt")
  data=lapply(file_list, read.table, header=FALSE, sep="")
  for (i in 1:length(data)){data[[i]]<-cbind(data[[i]],file_list[i])}
  data_rbind <- do.call("rbind", data) 
  colnames(data_rbind)[c(1,2,3,4,5,6)]<-c("sample", "chr", "start","stop", "count", "type")
```
Merge data frames into one data frame:

  `datafr <- do.call("rbind", data)`

Change column names and create new "occur" column:

  `datafr$occur <- 1`
  
 ` colnames(datafr)[c(1,2,3,4,5,6,7)]<-c("chr", "start", "stop", "count", "type", "sample", "occur")`

Make sure **datafr** now has seven appropriately-named columns

Now run commonCNV.R script, the default window size is 250

If you want to remove background CNVs, include that data frame as an input after it is created using the above method

  `df.output <- commonCNV(datafr, [window], [background.datafr])`
