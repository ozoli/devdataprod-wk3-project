library(shiny)
library(car)
library(datasets)

#
mpgModel <- lm(mpg ~ am+wt+hp+disp+cyl, data = mtcars);

# shiny server to use the MPG model for the given inputs
shinyServer(
  function(input, output) {          
    Data = reactive({
      validate(
         need(input$manual != input$automatic, "Please select either Manual or Automatic")      
      )
      amVal <- 1
      if (input$manual) {
        amVal <- 0
      }
      df <- data.frame(am=amVal,wt=input$wt,hp=input$hp,disp=input$disp,cyl=as.numeric(as.character(input$cyl)))
      prediction <- predict(mpgModel, df, se.fit=TRUE)
      table <- data.frame(prediction)
      return (list(fit=prediction[[1]], se.fit=prediction$se.fit, residual.scale=prediction$residual.scale, df=prediction$df))
    })

    output$mpgFit <- renderText(paste("Miles Per Gallon", sprintf(Data()$fit[1], fmt='%#.2f')))
    output$mpgSeFit <- renderText(paste("Standard Error of Predicated Means", sprintf(Data()$se.fit[1], fmt='%#.2f')))
    output$mpgResidualScale <- renderText(paste("Residual Standard Deviations", Data()$residual.scale[1]))
    output$mpgDf <- renderText(paste("Degrees of Freedom for Residual", sprintf(Data()$df[1], fmt='%#.2f')))
  }
)
