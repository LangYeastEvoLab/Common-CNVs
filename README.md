# Common-CNVs
Find recurrent copy number variants from Control-FREEC output

## Getting Started

After running Control-FREEC on your samples, download the CNV files to your computer
>these should be small text files containing information of called CNVs

You should have a .txt file for each sample containing CNV information

Place all these files in your working directory

## Importing Control-FREEC CNV files

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

## Running commonCNV.R

Now run commonCNV.R script, the default window size is 250

`df.output <- commonCNV(datafr, [window], [background.datafr])`

If you want to remove background CNVs (eg from a control group), include that data frame as the *background.datafr* input

*Note: background.datafr should be formatted using the same procedure listed above in "Importing Control-FREEC CNV files"*

  
