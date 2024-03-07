## OVERVIEW TAB INFO

library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(shinythemes)

joined_data <- read.csv("joinedandcleaned.csv")

overview_tab <- tabPanel("Overview",
  fluidRow(
    column(4,
           div(style = "background-color: #737373; padding: 20px;",
               h1(strong("Introduction")),
               p("As avid music fans, we wanted to create a website that highlights popular music as it relates to other forms of media. Our project examines and cross-references data from American Idol, a popular show centered on contestants covering music to win a recording contract with Hollywood Records, with the Billboard Hot 100 charts."),
               h1(strong("Questions")),
               p("1. What songs and artists that appear most in the Billboard Charts and how often they appear in American Idol?"),
               p("2. Which artists and songs that show up most in the winner and finalist list for American Idol AND the Billboard Charts?"),
               p("3. Has American Idol contestants shown up on the Billboard Charts themselves with their own original music?"),
               h1(strong("Data")),
               p("Authors: Winston Hermawan, Kimberly Quiocho, Gauri Verma"),
               p("Affiliation: INFO 201: Technical Foundations of Informatics | University of Washington: School of Informatics"),
               p("Final Project - WI 2024")
               )
           ),
  column(8,
         img(src = "https://cdn.britannica.com/68/128668-050-54406AE3/Judges-season-American-Idol-Randy-Jackson-Kara.jpg", height = "50%", width = "50%")
         )
  )
)


## VIZ 1 TAB INFO

viz_1_sidebar <- sidebarPanel(
  h2("Options for Visualization"),
  sliderInput("yearRange", "Select Year Range",
              min = 2000, max = 2020,
              value = c(2005, 2015)),
  sliderInput("billboardThreshold", "Billboard Appearance Threshold",
              min = 0, max = 100,
              value = 10)
)

viz_1_main_panel <- mainPanel(
  h2("Simplified Visualization of Popularity"),
  plotlyOutput(outputId = "simplePlot")
)

viz_1_tab <- tabPanel("Visualization of Popularity",
                      sidebarLayout(
                        viz_1_sidebar,
                        viz_1_main_panel
                      )
)

server <- function(input, output) {
  output$simplePlot <- renderPlotly({
    filtered_data <- joined_data %>%
      filter(timesOnBillboard >= input$billboardThreshold) %>%
      arrange(desc(timesOnBillboard))
    plot <- ggplot(filtered_data[1:10,], aes(x=reorder(song, timesOnBillboard), y=timesOnBillboard, fill=artist)) +
      geom_bar(stat="identity") +
      theme_minimal() +
      labs(title="Top Songs by Billboard Appearances", x="Song", y="Times on Billboard") +
      coord_flip() 
    ggplotly(plot)
  })
}

## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

viz_2_main_panel <- mainPanel(
  h2("Vizualization 2 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_2_tab <- tabPanel("Viz 2 tab title",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO

viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

viz_3_main_panel <- mainPanel(
  h2("Vizualization 3 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_3_tab <- tabPanel("Viz 3 tab title",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Key Findings",
                           h1("Research"),
                           p("Our investigation into the correlation between American Idol performances and their subsequent success on the Billboard charts yielded significant insights."),
                           h2("Specific Takeaways:"),
                           p(
                             p("American Idol provides a prominent platform for aspiring singers, influencing song popularity and artist commercial success."),
                             p("There is a clear correlation between contestants' success on American Idol and their achievements on the Billboard charts."),
                             p("Songs performed on the show, like 'Stay,' receive a notable boost in popularity."),
                             p("The show serves as a career-launching pad and a means for artists to gain widespread recognition."),
                             p("American Idol's diverse musical selections across genres and eras enrich the viewer's experience and highlight cultural richness.")
                           ),
                           h2("Insights:"),
                           p(
                             p("American Idol acts as a powerful catalyst for music promotion and artist visibility."),
                             p("The success of songs on Billboard charts after being performed on the show illustrates the show's profound impact on music careers."),
                             p("The variety of music on American Idol contributes significantly to its cultural and entertainment value.")
                           ),
                           h2("Conclusion:"),
                           p("The synthesis of our research highlights American Idol as a formidable force in the music industry, serving not just as a mere entertainment platform, but as a substantial influencer shaping the popular music landscape. American Idol has consistently served as a springboard for musical careers through its decades-long run, catapulting performances from its stage onto the Billboard charts with remarkable frequency. This phenomenon evidences the show's remarkable capacity to forecast and forge musical trends and preferences. The ripple effects extend beyond immediate commercial success, affecting music production, artist development, and even the broader culture of music consumption. As we've seen, performances on American Idol correlate with a demonstrable increase in song popularity, suggesting that the show's audience has a voracious appetite for the music they hear on the program, which translates into significant commercial outcomes. Furthermore, American Idol's musical aspect celebrates and promotes diversity in musical genres, fostering an appreciation for various musical expressions. This, in turn, contributes to a vibrant cultural tapestry and reinforces American Idol's role as a critical cultural institution. As such, American idol's influence is wide beyond the television screens and into the core of the American music scene, affirming its role as a cultural force and a powerhouse of music promotion.")
)

ui <- navbarPage(strong("American Idol and the Billboard Charts"),
                 theme = shinytheme("superhero"),
                 overview_tab,
                 viz_1_tab,
                 viz_2_tab,
                 viz_3_tab,
                 conclusion_tab
)