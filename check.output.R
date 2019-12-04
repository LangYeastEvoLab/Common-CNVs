check.output<-function(wind,chr.temp,start.temp,stop.temp,type.temp,df.output){
  
  #script by RCV 12/3/19
  #takes information from commonCNV.R script and checks if query CNV is in output file or not
  
  #double window size
  wind<- (wind*2)
  
  #if first line added to output file, returns 0 to ensure it's added to output df
  if(nrow(df.output) < 1){
    return(0)
  }
  else{
  for(i in 1:nrow(df.output)){

    chr.compare <- df.output[i,1]
    start.compare <- df.output[i,2]
    stop.compare <- df.output[i,3]
    type.compare <- df.output[i,5]
    
    #if a CNV already exists in output df, returns what line that duplicate is on to up it's occur number
    if(type.compare == type.temp && ((start.temp >= (start.compare - wind)) && (start.temp <= (start.compare + wind))) && ((stop.temp >= (stop.compare - wind)) && (stop.temp <= (stop.compare + wind))) && (chr.temp == chr.compare)){
      return(i)
    }
  }
  }
  #if CNV wasn't found, returns 0 to add it to output df
  return(0)
}
