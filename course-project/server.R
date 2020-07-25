library(shiny)
library(ggplot2)
library(caret)
library(dplyr)
library(klaR)
library(randomForest)

data(iris)

set.seed(123)

# split the data in training and test set
inTrain <- createDataPartition(y=iris$Species, p=0.5, list=FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]

# trains the model predicts and plots the outcome
getPlot <- function(method) {
  mod = train(Species ~ .,data=training,method=method)
  p = predict(mod,testing);
  correctPredictions = (p==testing$Species)
  
  testing$correctPredicted <- correctPredictions
  dplyr::filter(testing, correctPredicted == FALSE)
  
  plot1 <- qplot(Petal.Width, Sepal.Width, colour=Species, data=testing)
  plot1 + geom_point(data = dplyr::filter(testing, correctPredicted == FALSE), shape = 21, colour = "red", size = 5, stroke = 1)
}

shinyServer(
  function(input, output) {
    output$newPlot <- renderPlot({
      getPlot(input$method)
    })
  }
)
