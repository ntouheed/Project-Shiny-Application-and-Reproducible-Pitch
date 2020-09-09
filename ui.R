library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Price predictor for Houses"),
  
  # Sidebar with options selectors
  sidebarLayout(
    sidebarPanel(
      helpText("This application is a predictor for the price of a house based on its characteristics."),
      h3(helpText("Select:")),
      numericInput("sqft", label = h4("Sqft_Living"), step = 100, value = 700),
      selectInput("floors", label = h4("Floors"),
                  choices = list("Unknown" = "*", "1" = "1","1.5" = "1.5", "2" = "2",
                                            "2.5" = "2.5","3" = "3", "3.5" = "3.5")),
      selectInput("waterfront", label = h4("Waterfront"),
                  choices = list("Unknown" = "*", "0" = "0", "1" = "1")),
      selectInput("condition", label = h4("Condition"),
                  choices = list("Unknown" = "*", "1" = "1", "2" = "2",
                                      "3" = "3", "4" = "4", "5" = "5"))
    ),
    
    # Show a plot with house and regression line
    mainPanel(
      plotOutput("distPlot"),
      h4("Predicted value of this house is:"),
      h3(textOutput("result"))
    ),
  )
))