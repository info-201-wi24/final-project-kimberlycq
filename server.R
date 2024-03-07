
server <- function(input, output){
  
  # TODO Make outputs based on the UI inputs here
  
}

joined_data <- read.csv("joinedandcleaned.csv")
server <- function(input, output) {
  output$simplePlot <- renderPlotly({
    filtered_data <- joined_data %>%
      filter(timesOnBillboard >= input$billboardThreshold) %>%
      filter(year >= input$yearRange[1], year <= input$yearRange[2]) %>%
      arrange(desc(timesOnBillboard))
    plot <- ggplot(filtered_data[1:10,], aes(x=reorder(song, timesOnBillboard), y=timesOnBillboard, fill=artist)) +
      geom_bar(stat="identity") +
      theme_minimal() +
      labs(title="Top Songs by Billboard Appearances", x="Song", y="Times on Billboard") +
      coord_flip() 
    ggplotly(plot)
  })
}