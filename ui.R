# ui.R
# ConfidenceIntervalSimulator_UI.R
#
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Confidence Interval Simulator"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("mu",
                  "Value of Mu (Population Mean):",
                  min = -300,
                  max = 300,
                  value = 0),
      numericInput("sigma",
                  "Value of Sigma (Population Std. Dev.):",
                  min = 0.001,
                  max = 1000,
                  value = 1,
                  step = 0.1),
      sliderInput("sample_number",
                  "Number of Confidence Intervals \n (Number of Samples Drawn):",
                  min = 1,
                  max = 500,
                  value = 100),
      sliderInput("sample_size",
                  "Sample Size (Per Confidence Interval):",
                  min = 1,
                  max = 10000,
                  value = 50),
      numericInput("pop_size",
                  "Size of Population:",
                  min = 1,
                  max = 1e7,
                  value = 1e5),
      sliderInput("confidence_level",
                  "Confidence Level:",
                  min = 0.50,
                  max = 0.99,
                  value = 0.95,
                  step = 0.001,
                  round = TRUE)
    ),

    # __Variables__
    # mu = 0
    # sigma = 1
    # sample_number = 100
    # sample_size = 50
    # confidence_level=0.95
    # pop_size = 1e5

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      textOutput("text1")
    )
  )
))
