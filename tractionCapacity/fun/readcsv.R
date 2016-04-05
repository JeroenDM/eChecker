#' Read csv file from eChecker test and return as data.frame
#'
#' @param fileName Name of the file with extension .csv included.
#' @param compressed Boolean, when TRUE, al parameters not in "columns" will be omitted.
#' @param columns Columns which should be ommitted when "compressed" is TRUE.
#' @return date.frame with test data from the csv file.
#' @examples
#' readcsv("calna1_05_04.csv", TRUE)

readcsv <- function(fileName, compressed=F, columns=c("ta", "v", "Pa1")) {
  
  data <- read.csv2(paste("data/", filename, sep="")) # read file from data folder
  
  if (compressed) {
    data <- data[,columns] # ommit data not in columns
  }
  
  data # return data frame
}