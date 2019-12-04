check.background <- function(wind, chr.3,start.3,stop.3,type.3, background){
  
  #script by RCV 12/4/19
  #takes information from commonCNV.R script and checks if query CNV is in background file or not
  
  wind <- (wind*2)
  
  for(i in 1:nrow(background)){
    
    chr.compare <- background[i,1]
    start.compare <- background[i,2]
    stop.compare <- background[i,3]
    type.compare <- background[i,5]
    
    if(type.compare == type.3 && ((start.3 >= (start.compare - wind)) && (start.3 <= (start.compare + wind))) && ((stop.3 >= (stop.compare - wind)) && (stop.3 <= (stop.compare + wind))) && (chr.3 == chr.compare)){
      return(TRUE)
    }
  }
  return(FALSE)
}
