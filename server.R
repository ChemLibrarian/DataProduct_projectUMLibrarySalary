
# This is the server logic for a Shiny web application.


library(shiny)
library(dplyr)
library(ggplot2)
# load dataset from the current directory
UMLibrarySalarly2002_2014 <- read.csv("UMLibrarySalary2002_2014.csv")

shinyServer(function(input, output) {

  output$salaryPlot <- renderPlot({

    # calculating and plotting based on input$appointment_title from ui.R
          salarydata <- UMLibrarySalarly2002_2014 %>% 
                  filter(APPOINTMENT.TITLE == input$appointment_title) %>%
                  group_by(Year) %>%
                  mutate(count = n())
          
    # draw the plot for trends of salary change for the selected appointment title
    ggplot(data = salarydata, aes(x = as.factor(Year), y = APPT.ANNUAL.FTR)) +
            geom_boxplot(aes(fill=count)) +
            scale_fill_continuous(low = "#edf3f8", high = "#528cbc", 
                                  name = "Number of individuals" ) +
            stat_summary(fun.y=mean, geom="point", shape=5, size=4) +
            ggtitle("Trends of Salary Changes of the Selected Appointment Title\nUniversity of Michigan Library, Ann Arbor, MI 2002 - 2014")+
            theme_bw() +
            theme(plot.title = element_text(size = 14, face = "bold"), 
                  axis.title.y = element_text(size = 14), 
                  axis.title.x = element_text(size = 14)) + 
            scale_x_discrete("Year") +
            scale_y_continuous("Median Salary ($)") 
            

  })

})
