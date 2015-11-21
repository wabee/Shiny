library(shiny)

shinyUI(navbarPage("Regression",
  tabPanel("Data",
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      radioButtons('dec', 'Decimal',
                   c(Comma=',',
                     Dot='.'),
                   '.'),
      radioButtons('quote', 'Quote',
                   c(None='',
                     'Double Quote'='"',
                     'Single Quote'="'"),
                   '"')
),
    mainPanel(
      tableOutput('contents')
    )
  )
),
tabPanel("Model",
        sidebarLayout(
        sidebarPanel(
        uiOutput('dv'),        
        uiOutput('iv'),
        actionButton("goButton", "Run!")),
        mainPanel(
                verbatimTextOutput('model')
                )
)),
tabPanel("About",
        sidebarLayout(
        sidebarPanel(),
        mainPanel(
        h3("About this App"),
        p("Regression Analysis is a common and useful statistical tool
          used to analyze the relationship between a dependent variable and
          one or several independent variables"),
        p("This simple tool allow the user to upload and import a csv file
          in the data tab and conduct a regression analysis by selecting a dependent
          variable and one or several independent variables in the model tab"),
        p("Using the application is straight forward and should not present any difficulty.
          There is an error message initially which I suspect is a bug in the 'as.formula' function but this doesn't affect the 
          modelling paramters")
                 )))
))
