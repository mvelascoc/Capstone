library(shiny)

shinyUI( 
    pageWithSidebar(
    # Application title 
        headerPanel("Predicting text in (kind of)real time"),
    sidebarPanel(
        h4("Please write your text. Predictions will be available when you send the text."),
        h5("Designed for English only."),
        textInput('typedText', 'Type here your text', value = ""),
        submitButton("Send")

    ), 
    mainPanel(
       
        h3("Looking for que next word after"),
        verbatimTextOutput("myword"),
        h3("Your text next word is one of these?"),
        verbatimTextOutput("prediction"),
        
        p("This document is made as part of the Data Science Capstone for the Data 
            Science Specialization in Coursera (March/April 2015). author: Maria Velasco
            date: April 26 2015 8:00."),
        p("Documentation available at http://rpubs.com/mvelascoc/CapstoneFinal")
        
    ) )
)

