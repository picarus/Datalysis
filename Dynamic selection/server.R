library(shiny)
library(datasets)
library(ggplot2)

# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output, session) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars,
           "mtcars" = mtcars,
           "iris" = iris,
           "diamonds" = diamonds)
  })
  
  varXsel <- reactive({
    input$varX
  })
  
  logXsel <- reactive({
    input$logX
  })
  
  varYsel <- reactive({
    input$varY
  })
  
  logYsel <- reactive({
    input$logY
  }) 
  
  factorsSel <-reactive({
    input$factors
  })
  
  observe({
  # Change values for input$var
    updateSelectInput(session, "varX",          
                    choices = c(names(datasetInput()))
    ) 
    updateSelectInput(session, "varY",
                      choices = c(names(datasetInput()))
    )
    updateSelectInput(session, "factors",
                      choices = c('Choose'='',names(datasetInput())[sapply(datasetInput(),is.factor)])
    )
  })
  
#   session$onSessionEnded(function() {
#     obs$suspend()
#   })
  
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # Show the first "n" observations
  output$view <- renderDataTable({
    datasetInput()
  })
  

  output$image <- renderPlot({
    p <- ggplot(data = isolate(datasetInput()), aes_string(varXsel(), varYsel()) ) +
      geom_point()+
      geom_smooth() 
    if (logXsel()) {
      p <- p + scale_x_log10()
    }
    if (logYsel()) {
      p <- p + scale_y_log10()
    }
    if (factorsSel()!=''){
      p <- p + facet_wrap(factorsSel())
    }
    print(p)
      
  })


})