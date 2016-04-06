#-------------------------------------------------
# read eChecer csv data file, if needed, compress

readcsv <- function(fileName, compressed=F, columns=c("ta", "v", "Pa1")) {
  
  data <- read.csv2(paste("data/", fileName, sep="")) # read file from data folder
  
  if (compressed) {
    data <- data[,columns] # ommit data not in columns
  }
  
  data$ta = data$ta / 1000 # convert time to seconds
  
  data # return data frame
}

# Faster read function for big csv files with fread commando
# requires library data.table
readcsv2 <- function(fileName, compressed=F, columns=c("ta", "v", "Pa1")) {
  
  data <- fread(paste("data/", fileName, sep=""), sep=";", dec=",", data.table = F)
  
  if (compressed) {
    data <- data[,columns] # ommit data not in columns
  }
  
  data$ta = data$ta / 1000 # convert time to seconds
  
  data # return data frame
}

# library(data.table)
# test <- fread('data/calna1_05_04.csv', header = TRUE, dec=",")

#-------------------------------------------------
#calculate calibration power and speed based on cal data frame
# If there are no 9 minutes of calibration time, the calibration
# interval is shorter

calibrate <- function(data) {
  # select data from minute 4 to minute 9
  # 5 minutes of calibration data after warm up
  sel <- subset(data, ta > 240 & ta < 540)
  
  list( Pmean=mean(sel$Pa1, na.rm = T),
        vmean = mean(sel$v, na.rm = T) )
}

#-------------------------------------------------
# add marker when the assistance started/stopped
# column name: marker
# value: 0 if no assistance, 1 if assistance
# return: modified data frame

