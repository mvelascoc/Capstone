options(rpubs.upload.method = "internal")
options(RCurlOptions = list(verbose = FALSE, capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"), ssl.verifypeer = FALSE))

setwd("~/Google Drive/Cursos/Capstone/Code")

maxData <- 10000
twitterData <- readLines(file("en_US.twitter.txt","r"), n=maxData)
newsData <- readLines(file("en_US.news.txt","r"), n=maxData)
blogsData <- readLines(file("en_US.blogs.txt","r"), n=maxData)

library(tau)

data <- c(twitterData, newsData, blogsData)
d2<-textcnt(data, method="string",n=2L,split = "[[:space:][:punct:][:digit:]]", decreasing=TRUE)
az2<-data.frame(counts = unclass(d2), size = nchar(names(d2)))

d3<-textcnt(data, method="string",n=3L,split = "[[:space:][:punct:][:digit:]]", decreasing=TRUE)
az3<-data.frame(counts = unclass(d3), size = nchar(names(d3)))

pals <- row.names(az2)
pals2 <- row.names(az3)

saveRDS(pals, file = "pals.rds", ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)

saveRDS(pals2, file = "pals2.rds", ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)


