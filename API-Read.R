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
  #length(this.content[5])
  #as.data.frame(this.content)
  this.content.df <- do.call(what = "rbind",
                             args = lapply(this.content, as.data.frame))
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
VideoId <- as.data.frame("df616c07-2b34-4d29-9f03-a2b00c990aba")

# und dann loop über VideoId
VideoId <- as.data.frame("5297e7ec-a028-47b0-a83d-8461fd8f2b18")
VideoId <- as.data.frame("ef97fb4a-8ed4-4fa6-807b-75191bcab5fc")
endpoint <- "http://srgssr-prod.apigee.net/integrationlayer/2.0/srf/mediaComposition/video/"
apikey <- "O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"
cURL <- paste0(endpoint , VideoId , "?apikey=", apikey)
api_out <- metadataGETtoDataFrame(cURL = cURL)
# call Subtitles from URL 
api_out$chapterList.subtitleList.clear <- getURL(unlist(api_out$chapterList.subtitleList)[1])

### für die gleiche ID noch die Subtitles holen
cURL <- paste0(endpoint , VideoId , "?apikey=", apikey)
GETtoDataFrame()



# 2. Hier Metadaten holen: bu-mediaComposition-video-videoId-get
# https://api.srgssr.ch/audio-and-video-metadata/apis/get/%7Bbu%7D/mediaComposition/video/%7BvideoId%7D


# oder so: 

endpoint <- "http://srgssr-prod.apigee.net/integrationlayer/2.0/srf/showList/tv/alphabetical"
apikey <- "O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"
characterFilter <- "a" 
cURL <- paste0(endpoint , "?apikey=", apikey, "&characterFilter=", characterFilter )
api_out <- GETtoDataFrame(cURL = cURL)
api_out[1,]


#### most watched Videos 
cURL <-"http://srgssr-prod.apigee.net/integrationlayer/2.0/srf/mediaList/video/mostClicked?apikey=O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"
raw.result <- GET(cURL)
this.raw.content <- rawToChar(raw.result$content)
this.content <- fromJSON(this.raw.content)



api_out <- GETtoDataFrame(cURL = cURL)
api_out[1,]



#### teletext <- hier gibt es die Infos für die CSV für Basil. noch rausfinden welche Seite.... 
# bu-mediaList-video-mostClicked-get
cURL <-  "http://srgssr-prod.apigee.net/teletext/live/page?page=201&channel=SRF1&apikey=O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"
#endpoint <- "http://srgssr-prod.apigee.net/teletext/live/page"
#apikey <- "O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"
#cURL <- paste0(endpoint , "?apikey=", apikey )
api_out <- GETtoDataFrame(cURL = cURL)
api_out[1,] #Encoding ??? WTF...


#### landingpage-landingPageContentId-get <- was ist die "landingPageContentId" 
#### https://api.srgssr.ch/audio-and-video-metadata/apis
library(RCurl)
library(XML)

# assign input (could be a html file, a URL, html text, or some combination of all three is the form of a vector)
input <- "https://ws.srf.ch/subtitles/urn:srf:ais:video:5297e7ec-a028-47b0-a83d-8461fd8f2b18/subtitle.vtt"


txt
##### ∂€v 


names(api_out)
head(api_out$numFound)
=======

# oder so: 

endpoint <- "http://srgssr-prod.apigee.net/integrationlayer/2.0/srf/showList/tv/alphabetical"
apikey <- "O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"
characterFilter <- "a" 
cURL <- paste0(endpoint , "?apikey=", apikey, "&characterFilter=", characterFilter )
api_out <- GETtoDataFrame(cURL = cURL)
api_out[1,]
>>>>>>> 0febfe72de3d6b9de388a7f0d9b048e2cb434a88
