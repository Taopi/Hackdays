#---- initial and functions ---#  

# Literatur: https://www.r-bloggers.com/accessing-apis-from-r-and-a-little-r-programming/

options(stringsAsFactors = FALSE) #just do that...  

packages = c("httr", "jsonlite", "lubridate") #packete laden: 
for (package in packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, repos="http://cran.rstudio.com/")
    library(package, character.only = TRUE)
  }
}
# function zum abrufen der API und schreiben in DF
GETtoDataFrame <- function(cURL) {
  raw.result <- GET(cURL)
  this.raw.content <- rawToChar(raw.result$content)
  this.content <- fromJSON(this.raw.content)
  this.content.df <- do.call(what = "rbind",
                             args = lapply(this.content, as.data.frame))
}

# Anwendung: 
# Aus API App: 
cURL <- "http://srgssr-prod.apigee.net/rts-archives-public-api/archives?apikey=O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"
api_out <- GETtoDataFrame(cURL = cURL)
api_out[1,]

# oder so: 

endpoint <- "http://srgssr-prod.apigee.net/integrationlayer/2.0/srf/showList/tv/alphabetical"
apikey <- "O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"
characterFilter <- "a" 
cURL <- paste0(endpoint , "?apikey=", apikey, "&characterFilter=", characterFilter )
api_out <- GETtoDataFrame(cURL = cURL)
api_out[1,]
