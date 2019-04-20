
library(shiny)
library(readxl)
library(ggplot2)
library(janitor)

bcl <- read_xlsx("Artemis_gov_1005.xlsx") %>% 
  clean_names()

ui <- fluidPage(titlePanel("Milestone Apr. 19"),
      sidebarLayout(
        sidebarPanel(
          checkboxGroupInput("stateInput", "State",
                   choices = c("MA", "ME", "NH", "VT", "RI", "CT"))
    ),
    mainPanel(plotOutput("artemis"),
              br(), br(),
              tableOutput("results"))
  )
)

server <- function(input, output) {
  filtered <- reactive({
    bcl %>% 
      filter(billing_province %in% c("MA", "ME", "VT", "NH", "ME", "CT", "RI")
             )
  })
  
  output$artemis <- renderPlot({
    ggplot(filtered(), aes(billing_province)) +
      geom_bar(stat = "count")
  })
  
  output$results <- renderTable({
    filtered()
  })
}

shinyApp(ui = ui, server = server)

# server <- function(input, output) {
#   output$artemis <- renderPlot({
#     filtered <-
#       bcl %>% 
#       filter(billing_province %in% c("MA", "NH", "VT", "NH", "ME", "CT", "RI"))
#             ggplot(filtered, aes(billing_province)) +
#               geom_bar(stat = "count")
#   })
#   output$artemis <- renderPlot({
#     filtered <-
#       bcl %>% 
#       filter(billing_province %in% c("MA", "NH", "VT", "NH", "ME", "CT", "RI"))
#   })
#     filtered
#}
# shinyApp(ui = ui, server = server)

