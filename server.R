#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
# GaltonFamily Server.R
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(HistData)
data(GaltonFamilies)
library(dplyr)
library(ggplot2)
theme_set(theme_classic())


# Define server logic required to draw a graph
    gf <- GaltonFamilies
    gf <- gf %>% mutate(father=father * 2.54, 
                                                 mother = mother * 2.54,
                                                 childHeight = childHeight * 2.54)
    
# linear model 
    model1 <- lm(childHeight ~ father + mother + gender, data = gf)
    
    shinyServer(function(input, output) {
        output$pText <- renderText({
            paste("Father's height is",
                  strong(round(input$inFh, 1)),
                  "cm, and mother's height is",
                  strong(round(input$inMh, 1)),
                  "cm, then:")
        })
        
        output$pred <- renderText({
            df <- data.frame(father=input$inFh,
                             mother=input$inMh,
                             gender=factor(input$inGen, levels=levels(gf$gender)))
            ch <- predict(model1, newdata=df)
            kid <- ifelse(
                input$inGen=="female",
                "Daugther",
                "Son"
            )
            paste0(em(strong(kid)),
                   "'s predicted height is going to be around ",
                   em(strong(round(ch))),
                   " cm"
            )
        })
        
    ### Define the Output Plot, Draw the plot with geom_point
        
        output$Plot <- renderPlot({
            kid <- ifelse(
                input$inGen=="female",
                "Daugther",
                "Son"
            )
            df <- data.frame(father=input$inFh,
                             mother=input$inMh,
                             gender=factor(input$inGen, levels=levels(gf$gender)))
            ch <- predict(model1, newdata=df)
            yvals <- c("Father", kid, "Mother")
            df <- data.frame(
                x = factor(yvals, levels = yvals, ordered = TRUE),
                y = c(input$inFh, ch, input$inMh))
                ggplot(df, aes(x=x, y=y)) +
                geom_point() + xlab("") + ylab("Height in cm") +
                scale_y_continuous(expand = c(0.5, 0.5), limits = c(0, NA)) +  
               #theme_minimal() + theme(legend.position = "none", plot.margin = unit(c(1,1,1,1),"cm")) + 
                    
                geom_point(aes(x = x, y = y), color = "red", size = 8, shape = 16)+ 
                ggtitle("Line Plot for start")
                #theme_minimal() +
                #theme(legend.position="none")
                })
    

})
