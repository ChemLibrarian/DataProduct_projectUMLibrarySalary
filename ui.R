
# This is the user-interface definition of a Shiny web application to show trends of 
# salary average and median for different appointment titles at the University of Michigan Library.
#

library(shiny)
# load dataset from the current directory
# UMLibrarySalarlySummary2002_2014 <- read.csv("UMLibrarySalarySummary2002_2014.csv")
UMLibrarySalarly2002_2014 <- read.csv("UMLibrarySalary2002_2014.csv")

# Data used in this application is downloaded from Faculty and Staff Salary Data 
# from the University of Michigan. http://quod.lib.umich.edu/e/errwpc/public/3/3/1/3314612.html

shinyUI(fluidPage(

  # Application title
  titlePanel("University of Michigan Library Salary Data 2002 - 2014"),

  # Sidebar with a pull down menu 
  sidebarLayout(
    sidebarPanel(
      helpText('This is an interactive browsing tool to visualize trends of salary changes of 
         different types of positions (Appointment Titles) at the University of Michigan Library
               from 2002 to 2014'),
        h3('Please select an'),
        selectInput("appointment_title",
                  "Appointment title:",
                  choices = levels(UMLibrarySalarly2002_2014$APPOINTMENT.TITLE)),
                  hr(),
        helpText("The trend of salary changes for the selected appointment title 
                  is displayed as box plots over time in the figures on the right side."),          
        helpText("For some appointment titles, data may not be available for all the years. 
Select titles such as ASSOC LIBRARIAN, ASST LIBRARIAN, SR ASSOC LIBRARIAN, or LIBRARIAN to see 
                 more complete plots.")
    ),

    # Show two plots of the generated salary trend plot
    mainPanel(
      plotOutput("salaryPlot"),
      helpText('The diamond shape in the boxplot represents the mean.'),
      helpText('(Data may or may not be available for all 
                 the years depending on the types of positions)'),
      h4('The salary data is retrieved from the Faculty and staff salary record 
         at University of Michigan Digital Library Production Service.'),
      h4(a("Click here to download the data", href = "http://quod.lib.umich.edu/e/errwpc/public/3/3/1/3314612.html", 
           target = "_blank")),
      h4('The downloaded data is preprocessed (see the R code in SalaryData.R) 
         to extract the Library data and filter out any appointments not 12-month based. ')
    )
  )
))
