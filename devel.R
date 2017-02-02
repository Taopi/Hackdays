packages = c("httr", "jsonlite", "lubridate" , "RWeka" ) #packete laden: 
for (package in packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, repos="USA (CA1) [https]")
    library(package, character.only = TRUE)
  }
}

??tm_map
data("crude")
library(tm)
library(RWeka)
myTdm <- api_out$chapterList.subtitleList.clear
class(myTdm)
temp <- myTdm
temp <- inspect(myTdm)
FreqMat <- data.frame(ST = rownames(temp), Freq = rowSums(temp))
row.names(FreqMat) <- NULL
FreqMat