Predicting text in real time 
========================================================
This document is made as part of the Data Science Capstone for the Data Science Specialization in Coursera (March/April 2015). 

Author: Maria Velasco - Date: April 26 2015  13:00

The implementation of the algorithm was included in a Shiny App, available at
https://mvelascoc.shinyapps.io/ShinyPredictor/

Scope of the project
========================================================
- Using the data from 3 text files in English, one including tweets from twitter, other news posts and a third one with blogs, I created an algorith that predicts next word to be written by the user. 
- The data is included in a corpus called HC Corpora (www.corpora.heliohost.org). The data is asumed to be of random topics (not filtered in any particular way).
- Initial idea to use grammar structures (explored in the Milestone) was not included just because of the complexity of the calculations. Could be done, but not with the available time, memory and calculation restriction. 

Prediction bases
========================================================
<small>Using the R tau library, a list of 2-grams and 3-grams where builted using part of the data from the 3 files (only 10000 registers from each file). Including 4-grams improves the accuracy, but require more data, so I decided no not to include them. 
Then, the prediction is based on the probability of the next word in the n-gram. Probability is calculated using the frequency of the occurrence.</small>
<small>Intuitively decided to present multiple alternatives, since a single prediction is not so accurate that will give the user confidence.</small>
Example of the 2-gram table creation
```
d<-textcnt(data, method="string",n=2L,split = "[[:space:][:punct:][:digit:]]", decreasing=TRUE)
az1<-data.frame(counts = unclass(d), size = nchar(names(d)))
```
Considerations
========================================================
- Data used in the algorith was limited based on the 10M restriction on the data to deploy in the Shiny app. This is an arbitrary selected restriction (could have been maximun time of processing), but worked in order to maintain a reasonable processing time. 2 files are used in the App, with data from 2 and 3 n-grams. Files are 2.1M and 4.9M 
- Using 2-grams increases the probability that a prediction is made. 3-grams are more precise when a prediction can be made. In order to equilibrate both, I present the first (best) predictions using the 2-gram and next 3 with 3-grams.
- This was concluded by comparing predictions (5 random registers from each 3 files) with both 2-gram and 3-gram probability predictions. Mixing them in this proportion gave the better prediction rate.

And my personal conclusions
========================================================
- n-gram based prediction is accurate enough to allow an acceptable prediction with a simple calculation algorithm.
- As sample data used for training is increased, the accuracy of the model also increases, but the computational requirements increse also. 
- Since language is different in twitter, blogs or news, in order to keep a better prediction, there is need to mix the training data. 
- Prediction algorithms are not so precise that a single certain prediction can be made. Probabilities need to be used and presented to users using the prediction.
<small>Code is available if you are interested, in https://github.com/mvelascoc/Capstone . finalCode file includes 4-grams but its not the version deployed as part of the project (because of the file size limit). </small>
