library(markdown)

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Motor Miles Per Gallon Predictor"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        helpText("Select your car attributes"),
        
        hr(),
        checkboxInput("automatic", "Automatic", TRUE),
        hr(),
        checkboxInput("manual", "Manual", FALSE),
        
       hr(),
        sliderInput("wt",
                    "Weight:",
                    min = 2.2, max = 3.6, value = 2.5, step= 0.1),
        hr(),        
        selectInput(inputId = "cyl",
                    label="Cylinders",choices=list("4"=1,"6"=2,"8"=3), selected=2),        
        hr(),
        sliderInput("hp",
                    "Horsepower:",
                    min = 80, max = 180,  value = 125),
        hr(),        
        sliderInput("disp",
                    "Displacement:",
                    min = 90, max = 370,  value = 140),
        hr()
      ),
          
    mainPanel(
      textOutput("mpgFit"),
      textOutput("mpgSeFit"),
      textOutput("mpgDf"),
      textOutput("mpgResidualScale"),
      includeHTML("doc.html")
    )
  )
))