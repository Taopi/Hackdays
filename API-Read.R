#---- initial and functions ---#  

# Literatur: https://www.r-bloggers.com/accessing-apis-from-r-and-a-little-r-programming/
options(stringsAsFactors = FALSE) #just do that...  
packages = c("httr", "jsonlite", "lubridate" , "tm" , "RXKCD" ,"wordcloud" ,"SnowballC" , "RCurl")
for (package in packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, repos="http://cran.rstudio.com/")
    library(package, character.only = TRUE)
  }
}

# function1 (zum abrufen der API und schreiben in DF bei Metadaten)
metadataGETtoDataFrame <- function(cURL) {
  raw.result <- GET(cURL)
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  this.content.df  <- as.data.frame(this.content)
}

# Metadaten aus API 
# FEHLT: für MArkus: Start & End & Sender <- daraus Sendungs ID ermitten ID holen ???? 

# 1. loop für Ids schreiben
# Dazu vector wie der hier 
# und dann loop über VideoId
VideoId <- as.data.frame("ef97fb4a-8ed4-4fa6-807b-75191bcab5fc")
# for loop
endpoint <- "http://srgssr-prod.apigee.net/integrationlayer/2.0/srf/mediaComposition/video/"
apikey <- "O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"
cURL <- paste0(endpoint , VideoId , "?apikey=", apikey)
api_out <- metadataGETtoDataFrame(cURL = cURL)
name <- api_out$episode.title
name <- paste0(gsub(" ","",name),".csv")
# call Subtitles from URL
api_out$chapterList.subtitleList.clear <- getURL(unlist(api_out$chapterList.subtitleList)[1])
api_out$chapterList.subtitleList <- api_out$chapterList.subtitleList.clear
outlist <- which(names(api_out) %in%c("chapterList.subtitleList","chapterList.resourceList","chapterList.analyticsData"))
write.csv(api_out[,-outlist], file = name, row.names = FALSE)

