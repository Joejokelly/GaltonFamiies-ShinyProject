# This application is used for Galton Family dataset
# It is used to predict the children height daugher or son
# You choose the Mother and fathers height using the slider and the Algorithm
# predicts the children's height using geom_point()
# run the application by clicking 'Run App' above.
# GaltonFamily Ui.R

library(shiny)

shinyUI(fluidPage (
    titlePanel("Galton Family Data, Father, Mother, son's age"),
      
    sidebarLayout(
        sidebarPanel(
            helpText("Galton Family father, mother height"),
            helpText("parameter"),
            sliderInput(inputId = "inFh",
              label = "Father heignt cm. ",
              value = 150,
              min = 150,
              max = 220,
              step = 1),
            
            sliderInput(inputId = "inMh",
                  label = "Mothers height cm ",
                  value = 140,
                  min = 140,
                  max = 200,
                  step = 1),
              
            radioButtons(inputId = "inGen",
                         label = "Childs gender",
                         choices = c("Female"="female", "Male" = "male" ),
                         inline = TRUE),
            submitButton("Submit")
        ),
        
    mainPanel(
        htmlOutput("pText"),
        htmlOutput("pred"),
        plotOutput("Plot", width="90%")
    )
    
  )
))
