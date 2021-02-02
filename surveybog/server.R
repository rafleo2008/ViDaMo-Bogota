library(shiny)

# Define server logic 
shinyServer(function(input, output, session) {
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })
#    dummyfunc <- eventReactive(input$actualizar,{dummycall(1)})
    output$utams <- renderLeaflet({
        utams <- st_read(paste(here(),"surveybog","src","UTAM.shp", sep = "/"  ))
#        n <- dummyfunc()
        print(here())
        tmap_leaflet(tm_shape(utams) + tm_polygons("LOCNombre") )
    })
    

})
dummycall <-function(int){
    return(int)
}