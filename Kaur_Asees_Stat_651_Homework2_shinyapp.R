#Exercise 11.6


library(macleish)
library(shiny)
library(ggplot2)


# Define UI for application that makes the plot
ui <- fluidPage(
    
    h3("Frequency of temperature over time"),
    
    selectInput("dataset",label="Select the dataset",
                choices=c("whately_2015", "orchard_2015")),
    
    dateInput("startdate", "Enter starting date", 
              value = as.Date("2015-01-01"),
              min = as.Date("2015-01-01"), 
              max = as.Date("2015-12-31")),
    
    dateInput("enddate", "Enter ending date",
              value = as.Date("2015-12-31"),
              min = as.Date("2015-01-01"), 
              max = as.Date("2015-12-31")),
    
    plotOutput("plot")
)



# Define server logic required to make the plot

server <- function(input, output) {
    
    output$plot <- renderPlot({
        
        if(input$dataset == "whately_2015"){
            
            df <- whately_2015 %>%
                filter( when >= input$startdate, when <= input$enddate)
            
            ggplot(data = df, aes(x = when, y = temperature)) +
                geom_line() +geom_smooth()
        }
        
        else if(input$dataset == "orchard_2015"){
            df1 <- orchard_2015 %>%
                filter( when >= input$startdate, when <= input$enddate)
            
            ggplot(data = df1, aes(x = when, y = temperature)) +
                geom_line() +geom_smooth()
        }
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

