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
jeopCorpus <- tm_map(jeopCorpus, removeWords, stopwords('german'))
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
x <- Corpus(VectorSource(x))
x <- tm_map(x, removePunctuation) # remove punctuation
x <- tm_map(x, tolower) # convert all words to lower case
x <- tm_map(x, removeNumbers) # remove all numerals
x <- tm_map(x, function(x)removeWords(x, stopwords("german"))) # remove grammatical words such as "ein", "ist", "war", etc.


x <- removeWords(x
                 , c(".",","," ","Sie","                                                      "
                     , stopwords("german")))
x <- gsub("\n"," ",x)
x <- gsub("-->"," ",x)
x <- gsub("-"," ",x)

x <- strsplit(x, " ")
x <- unlist(x)
x <- as.factor(x)
View(x)
table(x)
levels(x)
summary(x)
wordcloud(x)

myTdm <- TermDocumentMatrix(x)
temp <- inspect(myTdm)
FreqMat <- data.frame(ST = rownames(temp), Freq = rowSums(temp))
row.names(FreqMat) <- NULL
FreqMat


###### 


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

write.csv2(d, file = paste0(name,"term.matrix.csv"), row.names = T)
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

#### test
d
head(as.data.frame(term.matrix))
names <- colnames(test)
rownames(d) <- NULL
data <- cbind(names,d)
test <- test[order(test$`1`, decreasing = T),]
test
