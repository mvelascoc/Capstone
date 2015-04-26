library(UsingR)

predict <- function(typedText, givePred) {
    
    text <- gsub('[.]|[,]|[;]|[:]|[(]|[)]|[!]|[?]|[&]|[$]','', typedText)
    text <- gsub('[[:punct:][:digit:]]','',text)
    
    text <- gsub("^ *|(?<= ) | *$", "", text, perl=T)
    textopar <- strsplit(text, "[[:space:]]")
    len <- length(textopar[[1]])
    
    word <- " "
    tot2grams <- 5
    tot3grams <- 8 - tot2grams
    
    if (len > 0) {
    
        # there is at least one word, so find match
        tabla <- readRDS("pals.rds", refhook = NULL)
        word <- paste("^",textopar[[1]][len], sep="")
        i <- grep(word, tabla)
        
        len2 <- length(i)
        if (len2 > tot2grams)
            len2 <- tot2grams
        
        myPrediction <- paste (tabla[i[1:len2]], sep = " / ")
        
        if (len > 1) {
            # there are 2 words, so find better match
           # x2 <- import("https://raw.github.com/mvelascoc/Capstone/master/pals2.rds")
            tabla2 <- readRDS("pals2.rds", refhook = NULL)
            word <- paste("^",textopar[[1]][len-1], sep="")
            word <- paste(word,textopar[[1]][len], sep=" ")
            i2 <- grep(word, tabla2)
            
            len3 <- length(i2)
            if (len3 > tot3grams)
                len3 <- tot3grams
            
            temp <- paste (tabla2[i2[1:len3]], sep = " / ")
            myPrediction <- c(myPrediction, temp)

        }
    
    } else {
        myPrediction <- "Can't predict yet. No words"
       
    }
    
    if(!givePred) {
        # requested just the word
        return (word)
    }
    
    return (myPrediction)
}

shinyServer( function(input, output) {
    
    output$myword <- renderPrint({predict(input$typedText,FALSE)}) 
    output$prediction <- renderPrint({predict(input$typedText,TRUE)}) 
    
}
)