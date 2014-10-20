library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  titlePanel("Datalysis"),
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view. The helpText function is
  # also used to include clarifying text. Most notably, the
  # inclusion of a submitButton defers the rendering of output
  # until the user explicitly clicks the button (rather than
  # doing it immediately when inputs change). This is useful if
  # the computations required to render output are inordinately
  # time-consuming.
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("rock", "pressure", "cars", "mtcars", "iris", "diamonds")),
      
      selectInput("varX", "Choose a variable:", choices=c()),
      checkboxInput("logX", label="Apply log in X scale:", value=FALSE),
      selectInput("varY", "Choose a variable:", choices=c()),
      checkboxInput("logY", label="Apply log in Y scale:", value=FALSE),
      
      selectInput("factors", "Select a categorical variable:", choices=c()),
      
      helpText("Note: while the data view will show only the specified",
               "number of observations, the summary will still be based",
               "on the full dataset.")

    ),
    
    # Show a summary of the dataset and an HTML table with the
    # requested number of observations. Note the use of the h4
    # function to provide an additional header above each output
    # section.
    mainPanel(
      tabsetPanel(
        tabPanel("Summary",verbatimTextOutput("summary")),
        tabPanel("Observations",dataTableOutput("view")),
        tabPanel("Analysis",imageOutput("image"))
      )
    )
  )
))