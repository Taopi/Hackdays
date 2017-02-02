packages = c("httr", "jsonlite", "lubridate" , "tm" , "RXKCD" ,"wordcloud" ,"SnowballC") #packete laden: 
for (package in packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, repos="USA (CA1) [https]")
    library(package, character.only = TRUE)
  }
}

jeopCorpus <- Corpus(VectorSource(api_out$chapterList.subtitleList.clear))
jeopCorpus <- tm_map(jeopCorpus, PlainTextDocument)
jeopCorpus <- tm_map(jeopCorpus, removePunctuation)
jeopCorpus <- tm_map(jeopCorpus, removeWords, stopwords('english'))
jeopCorpus <- tm_map(jeopCorpus, stemDocument)
jeopCorpus <- tm_map(jeopCorpus, removeWords, c('the', 'this', stopwords('english')))
termFreq(jeopCorpus)
jeopCorpus[[1]]
wordcloud::wordcloud(jeopCorpus, max.words = 100, random.order = FALSE)


##### -->
x <- as.factor(api_out$chapterList.subtitleList.clear)
x <- api_out$chapterList.subtitleList.clear
x <- strsplit(x, "\n")
x <- unlist(x)
x <- as.factor(x)
summary(x)
'-->' %in% x

head(x)
as.factor("--") %in% x
class(lines)
### ---- Liste mit Worthäufigkeiten
x <-api_out$chapterList.subtitleList.clear
Encoding(x) <- "UTF-8"
x <- removeWords(x, stopwords("german"))
x <- gsub("\n"," ",x)
x <- gsub("-->"," ",x)
x <- strsplit(x, " ")
x <- unlist(x)
x <- as.factor(x)
table(x)
levels(x)
sapply()
summary(x)


myTdm <- TermDocumentMatrix(as.factor(api_out$chapterList.subtitleList.clear))
temp <- inspect(myTdm)
FreqMat <- data.frame(ST = rownames(temp), Freq = rowSums(temp))
row.names(FreqMat) <- NULL
FreqMat
