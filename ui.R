#
# Date: 7/14/2019
# Author: Fred Paredes
# Description: This is a shiny app for week 4 of Developing Data Products
#       The application will be hosted on https://fparedes2.shinyapps.io/week4assignment/
#       of the shinyapps.io website.
#


library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(
        fluidPage(
                
                titlePanel("Motor Trend Car Data Exploration"),
                
                # Create a new Row in the UI for selectInputs
                fluidRow(
                        column(4,
                               sliderInput("hp", label = h4("Horse Power (bhp):"),
                                           min = floor(sort(min(mtcars$hp))),
                                           max = ceiling(sort(max(mtcars$hp))),
                                           value = 200)
                        ),
                        column(4,
                               sliderInput("qrtsec",
                                           label = h4("Quater Mile Time (sec):"),
                                           round = TRUE,
                                           min = floor(sort(min(mtcars$qsec))),
                                           max = ceiling(sort(max(mtcars$qsec))),
                                           value = 20)
                        )
                ), # End Fluid Row
                
                # Show a plot of the generated distribution
                mainPanel(
                        fluidRow(
                                splitLayout(cellWidths = c("50%", "50%"),
                                            plotlyOutput("distPlot1"), 
                                            plotlyOutput("distPlot2"))
                        ),
                        plotlyOutput("distPlot3")
                )#End Main Panel
        )#End Fluid Page 
 )#End Shiny UI
  

