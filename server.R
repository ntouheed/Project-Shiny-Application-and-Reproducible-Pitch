library(shiny)
library(ggplot2)
library(dplyr)
library(rsconnect)
houseDf <- read.csv("kc_house_data.csv")
# Select columns to be used in the analysis
houseDf <- houseDf[,c(3,6,8,9,11)]

# Let us convert three of them as factors
houseDf$floors <- as.factor(houseDf$floors)
houseDf$waterfront <- as.factor(houseDf$waterfront)
houseDf$condition <- as.factor(houseDf$condition)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    # Select houseDf depending of user input
    house <- filter(houseDf, grepl(input$floors, floors),
                             grepl(input$waterfront, waterfront),
                             grepl(input$condition, condition))
    # build linear regression model
    fit <- lm(price~sqft_living, house)
    # predicts the price
    pred <- predict(fit, newdata = data.frame(sqft_living = input$sqft,
                             floors = input$floors,
                             waterfront = input$waterfront,
                             condition = input$condition))
    # Draw the plot using ggplot2
    plot <- ggplot(data=house, aes(x=sqft_living, y = price))+
      geom_point(aes(floors = waterfront), alpha = 0.3)+
      geom_smooth(method = "lm")+
      geom_vline(xintercept = input$sqft, floors = "red")+
      geom_hline(yintercept = pred, floors = "green")
    plot
  })
  output$result <- renderText({
    # Renders the text for the prediction below the graph
    house <- filter(houseDf, grepl(input$floors, floors),
                             grepl(input$waterfront, waterfront),
                             grepl(input$condition, condition))
    if (nrow(house) > 0) {
      fit <- lm(price~sqft_living, house)
      pred <- predict(fit, newdata = data.frame(sqft_living = input$sqft,
                             floors = input$floors,
                             waterfront = input$waterfront,
                             condition = input$condition))
      res <- paste(round(pred, digits = 1.5),"$")
      res
    }
  })
})
