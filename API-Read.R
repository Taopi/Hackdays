### Read APIs using R 



install.packages(c("httr", "jsonlite", "lubridate"))
library(httr)
library(jsonlite)
## 
## Attaching package: 'jsonlite'
## 
## The following object is masked from 'package:utils':
## 
##     View
library(lubridate)
options(stringsAsFactors = FALSE)

# so wie hier: https://www.r-bloggers.com/accessing-apis-from-r-and-a-little-r-programming/
url  <- "http://srgssr-prod.apigee.net/rts-archives-public-api/archives"
path <- "/rts-archives-public-api/archives?apikey=O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r "
raw.result <- GET(url = url, path = path)

# oder GET aus der cURL...
cURL <- "http://srgssr-prod.apigee.net/rts-archives-public-api/archives?apikey=O7lSaGGuhqBcLNB4yPFmnZiT26bfFN4r"

raw.result <- GET(cURL)
this.raw.content <- rawToChar(raw.result$content)
nchar(this.raw.content)
substr(this.raw.content, 1, 100)

this.content <- fromJSON(this.raw.content)
this.content[[1]]
raw.result$content
names(raw.result)
raw.result$status_code
raw.result$request
raw.result$cookies
