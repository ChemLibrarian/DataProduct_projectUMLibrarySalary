
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
  titlePanel("University of Michigan Library Salary Data 2002 - 2004"),

  # Sidebar with a pull down menu 
  sidebarLayout(
    sidebarPanel(
      h3('Please select an'),
        selectInput("appointment_title",
                  "Appointment title:",
                  choices = levels(UMLibrarySalarly2002_2014$APPOINTMENT.TITLE)),
                  hr(),
        helpText("The trends of salary average and salary median for the specific appointment title 
                 you select will display in the two figures on the right side."),          
        helpText("For some appointment title, data may not be available for all the years. 
Select titles such as ASSOC LIBRARIAN, ASST LIBRARIAN, SR ASSOC LIBRARIAN, LIBRARIAN, OR 
BOOK BINDER III to see better plots."),
      h4('The salary data is retrieved from the Faculty and staff salary record 
         at University of Michigan Digital Library Production Service.'),
      h4(a("Click here to download the data", href = "http://quod.lib.umich.edu/e/errwpc/public/3/3/1/3314612.html", 
           target = "_blank")),
      h4('The downloaded data is preprocessed (see the R code in SalaryData.R) 
         to extract the Library data and calculate the average salary and median 
         salary for specific appointment titles. ')
    ),

    # Show two plots of the generated salary trend plot
    mainPanel(
      plotOutput("salaryPlot_average"),
      plotOutput("salaryPlot_median")
    )
  )
))
