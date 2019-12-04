commonCNV <- function(input,window=250,background){
  
  #script by RCV 12/3/19
  #counts reccurent CNVs from control-freec output data
  #follow GitHub instructions to prepare our input file: 
  
  #store input and make new df
  df1 <- input
  df.output <- data.frame(chr=character(),start=numeric(),stop=numeric(),count=numeric(),type=factor(),sample=character(),occur=numeric())
  wind <- window

  #loop through each line, store CNV info for comparisons
  i <- 1
  x <- nrow(df1) + 1
  while (i < x){
    
    #assign row's values as temps
    chr.temp <- df1[i,1]
    start.temp <- (df1[i,2])
    stop.temp <- (df1[i,3])
    type.temp <- df1[i,5]
    
    #loop through every line below current (i), look for chr matches within start/stop window
    k <- i+1
    y <- nrow(df1)+1
    while (k < y){
      
      #store row's values as temps for comparison
      chr.compare <- df1[k,1]
      start.compare <- df1[k,2]
      stop.compare <- df1[k,3]
      type.compare <- df1[k,5]
      
      #chr must match and fall within window, I ignore mitochondiral CNVs
      if(type.compare == type.temp && chr.temp == df1[k,1] && df1[k,1] != "mt" && ((start.compare >= (start.temp - wind)) && (start.compare <= (start.temp + wind))) && ((stop.compare >= (stop.temp - wind)) && (stop.compare <= (stop.temp + wind)))){ 

          check <- check.output(wind,chr.compare,start.compare,stop.compare,type.compare,df.output)
          
          if(check > 0){
            df.output[check,7] <- (df.output[check,7]) + 1
            df1 <- df1[-k,]
            y <- y-1
          }
          
          if(check == 0){
            tdf<-data.frame(df1[k,1],df1[k,2],df1[k,3],df1[k,4],df1[k,5],df1[k,6],2)
            names(tdf) <- c("chr","start","stop","count","type","sample","occur") 
            df.output <- rbind(df.output,tdf)
            
            df1 <- df1[-k,]
            y<- y-1
          }
      }
      else{k<-k+1}
    }
    i <- i+1
    x <- nrow(df1)
  }
  
  #remove background CNVs if background file was given
  if(missing(background)){
  return(df.output)
  }
  else{
    j <- 1
    z <- nrow(df.output)
    while(j < z){
      
      chr.3 <- df.output[j,1]
      start.3 <- df.output[j,2]
      stop.3 <- df.output[j,3]
      type.3 <- df.output[j,5]
      
      bkgrnd.cnv <- check.background(wind,chr.3,start.3,stop.3,type.3,background)
      
      if(bkgrnd.cnv == FALSE){
        j <- j+1
      }
      
      if(bkgrnd.cnv == TRUE){
        df.output <- df.output[-j,]
        z <- z-1
      }
    }
    return(df.output)
  }
}
