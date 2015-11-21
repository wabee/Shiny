library(shiny)

shinyServer(function(input, output) {
        #Read Data
        filedata<-reactive({
          infile <- input$file1
          if(is.null(infile)){
                  return(NULL)
          }
          read.csv(infile$datapath, header=input$header, sep=input$sep,
                   quote=input$quote,dec=input$dec)       
  })
        output$contents <- renderTable({
        # Just show the first few lines in the UI
        head(filedata())
  })
        #Input Panels for Dependent and Independents
        output$dv = renderUI({
                selectInput('dv', h5('Dependent Variable'), choices = names(filedata()))
        })
        output$iv = renderUI({
                selectInput('iv', h5('Independent Variables'), multiple=T,
                            selected=names(filedata())[2], choices = names(filedata()))
         })

   
       
        

        output$model <- renderPrint({
                input$goButton
                isolate({
                        # regression formula
                        regFormula <- reactive({
                                as.formula(paste(input$dv,'~',paste(input$iv,collapse = '+')))
                        })
                        # Regression model
                        model <- reactive({
                                lm(regFormula(),data=filedata())
                        })
                summary(model())
                })
        })
})