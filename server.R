#server.R
library(shiny)
library(HistData)
data(GaltonFamilies)
library(dplyr)
library(ggplot2)

#dataset
gf <- GaltonFamilies

# linear model
regmod <- lm(childHeight ~ father + mother + gender, data=gf)

shinyServer(function(input, output) {
  output$parentsText <- renderText({
    paste("When the father's height is",
          strong(round(input$inFh, 1)),
          "inches, and the mother's is",
          strong(round(input$inMh, 1)),
          "inches, then the")
  })
  output$prediction <- renderText({
    df <- data.frame(father=input$inFh,
                     mother=input$inMh,
                     gender=factor(input$inGen, levels=levels(gf$gender)))
    ch <- predict(regmod, newdata=df)
    sord <- ifelse(
      input$inGen=="female",
      "Daugther",
      "Son"
    )
    paste0(em(strong(sord)),
           "'s predicted height would be approximately ",
           em(strong(round(ch))),
           " inches."
    )
  })
  output$barsPlot <- renderPlot({
    sord <- ifelse(
      input$inGen=="female",
      "Daugther",
      "Son"
    )
    df <- data.frame(father=input$inFh,
                     mother=input$inMh,
                     gender=factor(input$inGen, levels=levels(gf$gender)))
    ch <- predict(regmod, newdata=df)
    yvals <- c("Father", sord, "Mother")
    df <- data.frame(
      x = factor(yvals, levels = yvals, ordered = TRUE),
      y = c(input$inFh, ch, input$inMh),
      colors = c("red", "green", "blue")
    )
    ggplot(df, aes(x=x, y=y, color= colors, fill= colors)) +
      geom_bar(stat="identity", width=0.8) +
      xlab("") +
      ylab("Height (in)") +
      theme_minimal() +
      theme(legend.position="none") +
      scale_fill_manual(values = c("pink", "green4", "blue"))
      
  })
})
