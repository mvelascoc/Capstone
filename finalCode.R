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

d4<-textcnt(data, method="string",n=4L,split = "[[:space:][:punct:][:digit:]]", decreasing=TRUE)
az4<-data.frame(counts = unclass(d4), size = nchar(names(d4)))

pals3 <- row.names(az4)

saveRDS(pals3, file = "pals3.rds", ascii = FALSE, version = NULL,
        compress = TRUE, refhook = NULL)

###########
# this is the server function. Simulating IO entry with this variables
typedText <- "most of the"
givePred <- TRUE
############
    
    # clean the text
    text <- gsub('[.]|[,]|[;]|[:]|[(]|[)]|[!]|[?]|[&]|[$]','', typedText)
    text <- gsub('[[:punct:][:digit:]]','',text)
    
    text <- gsub("^ *|(?<= ) | *$", "", text, perl=T)
    textopar <- strsplit(text, "[[:space:]]")
    len <- length(textopar[[1]])
    
    word <- " "
    
    # decide on combination of predictions to present 
    # (number of predictions by type of n-gram. Using 2, 3 and 4)
    tot2grams <- 5
    tot3grams <- 5
    tot4grams <- 5
    
    # if there is at least a word, predict. Else signal user
    if (len > 0) {
        
        # there is at least one word, so find match with 2-gram
        tabla <- readRDS("pals.rds", refhook = NULL)
        word <- paste("^",textopar[[1]][len], sep="")
        i <- grep(word, tabla)
        
        len2 <- length(i)
        if (len2 > tot2grams)
            len2 <- tot2grams
        
        # best predictions are included
        myPrediction <- paste (tabla[i[1:len2]], sep = " / ")
        
        if (len > 1) {
            # there are 2 words, so find better match with 3-gram
            tabla2 <- readRDS("pals2.rds", refhook = NULL)
            word <- paste("^",textopar[[1]][len-1], sep="")
            word <- paste(word,textopar[[1]][len], sep=" ")
            i2 <- grep(word, tabla2)
            
            len3 <- length(i2)
            # if a better match was found, include it
            if (len3 > 0) {
            
                if (len3 > tot3grams)
                    len3 <- tot3grams
            
                temp <- paste (tabla2[i2[1:len3]], sep = " / ")
                myPrediction <- c(myPrediction, temp)
                
                if (len > 2) {
                    # there are 3 words, so find better match with 4-gram
                    tabla3 <- readRDS("pals3.rds", refhook = NULL)
                    word <- paste("^",textopar[[1]][len-2], sep="")
                    word <- paste(word,textopar[[1]][len-1], textopar[[1]][len], sep=" ")
                    i3 <- grep(word, tabla3)
                    
                    len4 <- length(i3)
                    # if a better match was found, include it
                    if (len4 > 0) {
                    
                        if (len4 > tot4grams)
                            len4 <- tot3grams
                    
                        temp <- paste (tabla3[i3[1:len4]], sep = " / ")
                        myPrediction <- c(myPrediction, temp)
                    }
                    
                }
            }
        }
        
        
    } else {
        myPrediction <- "Can't predict yet. No words"
        
    }
    


#############
myPrediction
word
