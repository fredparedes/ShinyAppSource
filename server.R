#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(tidyverse)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        plot1 <- reactive({
        # generate dataset based on inputs from ui.R
        mtx <- mtcars[which(mtcars$hp < input$hp & 
                                  mtcars$qsec < input$qrtsec), ] 
        
        plot_ly(data = mtx, type = "box") %>%
                add_boxplot(y = ~wt*1000, name = "Car Weight (Thousands of Pounds)", boxpoints = 'all') %>%
                layout(showlegend = FALSE)
        })
        
        plot2 <- reactive({
                # generate dataset based on inputs from ui.R
                mtx <- mtcars[which(mtcars$hp < input$hp & 
                                            mtcars$qsec < input$qrtsec), ] 
                
                plot_ly(data = mtx, type = "box") %>%
                        add_boxplot(y = ~mpg, name = "Miles Per Gallon", boxpoints = 'all') %>%       
                        layout(showlegend = FALSE)
        })
        
        plot3 <- reactive({   
                
        # generate dataset based on inputs from ui.R
        x <- mtcars[which(mtcars$hp < input$hp & 
                                  mtcars$qsec < input$qrtsec), ] 
        
        # access car names in row names
        x <- x %>% rownames_to_column()
        
        pallete <- c("red", "blue", "green")
        
        fit <- lm(mpg ~ wt, data = x)
        
        plot_ly(data = x, x = ~wt, y = ~mpg, type = "scatter", mode = "markers",
                text = ~paste("Car Name: ", x$rowname, "<br>Quarter Mile (sec): ", x$qsec), color = ~cyl, colors = pallete) %>%
                layout(autosize = TRUE) %>%
                layout(title = "Miles Per Gallon versus Weight") %>%
                add_lines(x = ~wt, y = fitted(fit)) %>%
                layout(showlegend = FALSE)
    
        })
        
        output$distPlot1 = renderPlotly({ plot1() })
        output$distPlot2 = renderPlotly({ plot2() })
        output$distPlot3 = renderPlotly({ plot3() })
})
