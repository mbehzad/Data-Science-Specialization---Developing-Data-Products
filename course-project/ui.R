library(shiny)

# Define UI for dataset viewer application
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Iris clasification with caret"),
  
    sidebarPanel(
      radioButtons("method", "Training method:",
                   c("Random forest (rf)" = "rf",
                     "Naive Bayes (nb)" = "nb",
                     "Linear Discriminant Analysis (lda)" = "lda",
                     "CART (rpart)" = "rpart")),
    ),
    mainPanel(
        h3('Results of prediction'),
        p('Using the build-in iris dataset, we will use different caret training algorithms and see which one has better results.'),
        p('We split the data in half and use the first half to train the data, and the second half to check if it can correctly clasify the results. i.e.'),
        code('caret::train(Species ~ ., data=training, method=method)'),
        hr(),
        p('missidentified items are marked with red circle'),
        
        plotOutput('newPlot')
    )
  )
)

