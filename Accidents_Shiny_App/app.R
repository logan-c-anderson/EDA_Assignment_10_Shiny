# ---
# title: "Accidents Quick View"
# author: "Logan Anderson"
# format: Shiny App
# ---

library(shiny)
library(shinythemes)
allData <- read.csv("combined_accident_data.csv")


# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("superhero"), #Theme
                navbarPage(
                  "United States Accidents (2021)",
                  
                  #App title
                  tabPanel("State",
                           sidebarPanel(titlePanel("Total Number of Accidents per State"),
                                        tags$h3("Select Bins:"),
                                        sliderInput("bins",
                                                    "Number of bins:",
                                                    min = 1,
                                                    max = 50,
                                                    value = 50)
                           ),
                           mainPanel(
                             h1(""),
                             
                             h3(""),
                             plotOutput("distPlot"),
                           )
                  ), #Navbar 1, tabpanel
                  tabPanel("Season",
                           sidebarPanel(titlePanel("Accidents per Season"),
                                        tags$h3("Choose Season"),
                                        radioButtons("radio", label = h3("Radio buttons"),
                                                     choices = list("Spring" = "April showers bring May flowers :)", 
                                                                    "Summer" = "Good times and tan lines :)", 
                                                                    "Fall" = "Happy Fall, Y'all! :)", 
                                                                    "Winter" = "Brrrr... Man, why do I live in South Dakota >:("), 
                                                     selected = "April showers bring May flowers :)"),
                                        
                                        hr(),
                                        fluidRow(column(3, verbatimTextOutput("value"))))
                  ),
                  tabPanel("Make/Model", "COMING SOON! Hit and Run/ Check Yes or Check No" 
                           # sidebarPanel(titlePanel("Pct. Accidents by Makes and Models"),
                           #              tags$h3("Make/Model"),
                           #              radioButtons("radio2", label = h3("Hit and Run?"),
                           #                           choices = list("Yes" = "Yes",
                           #                                          "No" = "No"),
                           #                           selected = "Yes"),
                           # 
                           #              hr(),
                           #              fluidRow(column(3, verbatimTextOutput("value2"))))
                  )
                ) #NavbarPage
) #fluid Page




# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    par(bg = "darkslategrey")
    # generate bins based on input$bins from ui.R
    x    <- result$ST_CASE
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'cornflowerblue', border = 'white',
         xlab = 'States (A-Z)',
         main = 'Total Number of Accidents per State') #Hist
    output$value <- renderPrint({ input$radio })
    
    radio <- switch(input$radio,
                    "Spring" = "April showers bring May flowers :)", 
                    "Summer" = "Good times and tan lines :)", 
                    "Fall" = "Happy Fall, Y'all! :)", 
                    "Winter" = "Brrrr... Man, why do I live in South Dakota >:(",
                    "Spring")
    
    # output$value2 <- renderPrint({ input$radio })
    # 
    # radio2 <- switch(input$radio,
    #                 "Yes" = "Yes", 
    #                 "No" = "No", 
    #                 "Yes")
  }) #Render plot
} #Function




# Run the application 
shinyApp(ui = ui, server = server)
