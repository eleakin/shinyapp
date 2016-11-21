#ui.R

library(shiny)

shinyUI(fluidPage(
  titlePanel("Predict the height of a child using Galton's model."),
  sidebarLayout(
    sidebarPanel(
      helpText("This application predicts height of a child by his or her gender and the height of the parents."),
      helpText("Please make a choice of parameters:"),
      sliderInput(inputId = "inFh",
                  label = "Father's height in inches:",
                  value = 60,
                  min = 60,
                  max = 80,
                  step = 0.5),
      sliderInput(inputId = "inMh",
                  label = "Mother's height in inches:",
                  value = 60,
                  min = 60,
                  max = 80,
                  step = 0.5),
      radioButtons(inputId = "inGen",
                   label = "Child's gender: ",
                   choices = c("Female"="female", "Male"="male"),
                   inline = TRUE)
    ),
    
    mainPanel(
      htmlOutput("parentsText"),
      htmlOutput("prediction"),
      plotOutput("barsPlot", width = "50%")
    )
  )
))
