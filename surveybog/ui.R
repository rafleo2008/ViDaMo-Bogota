##### Encuesta de movilidad de Bogotá, Dashboard
##### Librerías
#install.packages('rsconnect')
library(here)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus) ## Extra elements for dashboard
library(leaflet) #for producing interactive maps
library(sf) #for handling spatial data
library(tmap)
library(tmaptools)
##### Preparación

##### Cargar shapefiles

#global$zones <- st_read(paste(here(),"use_cases",global$implementation_value,"zone_shapefile","zone_system.shp",sep="/"))

# Define UI for application that draws a histogram
    ui = dashboardPagePlus(
        header = dashboardHeaderPlus(
            enable_rightsidebar = TRUE,
            rightSidebarIcon = "gears"
        ),
        sidebar = dashboardSidebar(
            width = 300,
            sidebarMenu(
                menuItem(
                    text = "Módulo",
                    tabName = "Módulo",
                    icon = icon("file")
                ),
                menuItem(
                    text = "Escala",
                    tabName = "Unidad geográfica",
                    icon = icon("map"),
                    radioButtons("geoUnit", "Seleccione unidad geográfica",
                        choices = list("UTAM" = "utam", "ZAT" = "zat")),
                    actionButton("actualizar","Actualizar")
                ),
                menuItem(
                    text = "Indicador",
                    tabName = "Indicador",
                    icon = icon("chart-bar")
                )
            )
        ),
        dashboardBody(
            fluidRow(
                boxPlus(
                    closable = FALSE,
                    status = "primary",
                    width = 12,
                    solidHeader = TRUE,
                    # Show specific units
                    conditionalPanel("input.geoUnit == 'utam'",
                        leafletOutput("utams", height = 850),
                        actionButton("metoo","Actualizar")),
                    conditionalPanel("input.geoUnit == 'zat'",
                        leafletOutput("zat", height = 850),
                        actionButton("hey_hey","ZAT")
                    #conditionalPanel(condition = "input.geoUnit")
                )
            )
        )),
        rightsidebar = rightSidebar(
            background = "dark",
            rightSidebarTabContent(
                id = 1,
                title = "Tab 1",
                icon = "desktop",
                active = TRUE,
                sliderInput(
                    "obs",
                    "Number of observations:",
                    min = 0, max = 1000, value = 500
                )
            ),
            rightSidebarTabContent(
                id = 2,
                title = "Tab 2",
                textInput("caption", "Caption", "Data Summary")
            ),
            rightSidebarTabContent(
                id = 3,
                icon = "paint-brush",
                title = "Tab 3",
                numericInput("obs", "Observations:", 10, min = 1, max = 100)
            )
        ),
        title = "Right Sidebar"
    )