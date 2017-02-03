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
api_out$chapterList.subtitleList.clear <- getURLContent(unlist(api_out$chapterList.subtitleList)[1])
#api_out$chapterList.subtitleList <- api_out$chapterList.subtitleList.clear
outlist <- which(names(api_out) %in%c("chapterList.subtitleList","chapterList.resourceList","chapterList.analyticsData"))
write.csv(api_out[,-outlist], file = name, row.names = FALSE)



#### ---- Wordcloud aus Subtitles 
###############################################################
corp <- Corpus(VectorSource(api_out$chapterList.subtitleList.clear)) # Create a corpus from the vectors
####
#corp <- tm_map(corp, stemDocument, language = "german") # stem words (inactive because I want intakt words)
corp <- tm_map(corp, removePunctuation) # remove punctuation
corp <- tm_map(corp, tolower) # convert all words to lower case
corp <- tm_map(corp, removeNumbers) # remove all numerals
corp <- tm_map(corp, function(x)removeWords(x, c("dass" ,stopwords("german")))) # remove grammatical words
corp <- Corpus(VectorSource(corp$content))  # convert vectors back into a corpus
term.matrix <- TermDocumentMatrix(corp)  # crate a term document matrix
term.matrix <- removeSparseTerms(term.matrix, 0.5) # remove infrequent words
term.matrix <- as.matrix(term.matrix)
# Create a term document matrix
term.matrix <- TermDocumentMatrix(corp)  # crate a term document matrix
term.matrix <- removeSparseTerms(term.matrix, 0.5) # remove infrequent words
term.matrix <- as.matrix(term.matrix)

dtm <- term.matrix
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
d$emission.start <- api_out$episode.publishedDate
d$firts.mention.milsec.after.emission.start <- 
write.csv2(d, file = paste0(name,"term.matrix.csv"), row.names = T, fileEncoding = "UTF-8")
set.seed(1234)

png(file = "fix.cloud.png", bg = "transparent")
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=rev(brewer.pal(8, "RdBu")))
dev.off()


write.table(api_out$chapterList.subtitleList.clear, file = "foo.txt", row.names = FALSE)

