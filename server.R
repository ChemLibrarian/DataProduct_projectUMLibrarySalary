
# This is the server logic for a Shiny web application.


library(shiny)
library(dplyr)
library(ggplot2)
# load dataset from the current directory
UMLibrarySalarly2002_2014 <- read.csv("UMLibrarySalary2002_2014.csv")

shinyServer(function(input, output) {

  output$salaryPlot_average <- renderPlot({

    # calculate mean and median based on input$appointment_title from ui.R
    salarydata <- UMLibrarySalarly2002_2014 %>% 
            filter(APPOINTMENT.TITLE == input$appointment_title) %>%
            group_by(Year) %>%
            summarise(Average = mean(APPT.ANNUAL.FTR), Median = median(APPT.ANNUAL.FTR))
         
    # draw the plot for trends of the average for a specific job
    ggplot(data = salarydata, aes(x = as.factor(Year), y = Average)) +
            geom_bar(stat = "identity", fill = "steelblue",color = "steelblue") +
            scale_x_discrete("Year") +
            scale_y_continuous("Average Salary ($)") +
            ggtitle("Trends of Average Salary of the Selected Appointment Title at the University of Michigan Library\nAnn Arbor Campus, 2002 - 2014\n(Data may or may not be available for all the years depending on positions)")+
            theme_bw() +
            theme(plot.title = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 14), axis.title.x = element_text(size = 14))
            

  })
  
  output$salaryPlot_median <- renderPlot({
          
          # generate bins based on input$bins from ui.R
          salarydata <- subset(UMLibrarySalarlySummary2002_2014, APPOINTMENT.TITLE == input$appointment_title)
          
          
          # draw the plot for trends of the average for a specific job
          ggplot(data = salarydata, aes(x = as.factor(Year), y = Median)) +
                  geom_bar(stat = "identity", fill = "steelblue",color = "steelblue") +
                  scale_x_discrete("Year") +
                  scale_y_continuous("Median Salary ($)") +
                  ggtitle("Trends of Median Salary of the Selected Appointment Title at the University of Michigan Library\nAnn Arbor Campus, 2002 - 2014\n(Data may or may not be available for all the years depending on positions)")+
                  theme_bw() +
                  theme(plot.title = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 14), axis.title.x = element_text(size = 14))
          
          
  })

})
