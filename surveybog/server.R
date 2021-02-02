library(shiny)

# Define server logic 
shinyServer(function(input, output) {
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })
    dummyfunc <- eventReactive(input$actualizar,{dummycall(1)})
    output$utams <- renderLeaflet({
        n <- dummyfunc()
        print("estamos en el mapa!!")
        tmap_leaflet(tm_shape(utams)+ tm_layout("UTAMS"))
    })
    

})
dummycall <-function(int){
    return(int)
}