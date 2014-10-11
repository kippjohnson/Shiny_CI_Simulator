# server.R
# ConfidenceIntervalSimulator_Server
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

output$distPlot <- renderPlot({


  lower_store = numeric()
  upper_store = numeric()
  range_store = numeric()

  pop_vec <- rnorm(input$pop_size, mean = input$mu, sd = input$sigma)

  for(i in 1:input$sample_number){
    x1 <- sample(x=pop_vec, size=input$sample_size ,replace=TRUE) # get samples
    xtest <- t.test(x1, conf.level = input$confidence_level)  # t.test on samples
    lower_store[i] <- xtest$conf.int[1]				   # assign upper and lower
    upper_store[i] <- xtest$conf.int[2]				   # ends to approp. vector
  }

    #x    <- faithful[, 2]  # Old Faithful Geyser data
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')

    plot(c(min(lower_store),max(upper_store)),c(0,input$sample_number),type="n",
         xlab = "Confidence Interval",ylab="Interval Number")

    abline(v=input$mu,lwd=2,lty=2,col='BLUE') # add line for true mean

    for(i in 1:input$sample_number){
      lines(c(lower_store[i],upper_store[i]),c(i,i)) #add lines containing interval to plot

      if(input$mu <= upper_store[i] && input$mu >= lower_store[i]){ # number of intervals containing mu
        range_store[i] = 1
      }

    }

  mu_within = sum(range_store,na.rm = TRUE)
  output$text1 <- renderText({
    c("The fraction of intervals containing the true mean:", mu_within/input$sample_number)
  })


    })
})
