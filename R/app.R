
#' Main Shiny App Function
#'
#' @param ... Additional parameters.
#'
#' @import shiny
#' @export
biodiversityApp <- function(...) {

  ui <- tagList(
    addExternalResources(),
    navbarPage(
      "Polish Biodiversity", id = "main",
      collapsible = TRUE,
      theme = bslib::bs_theme(
        version = "5",
        # bg = "#FFFFFF",
        # fg = "#000000",
        # primary = "#0199F8",
        # secondary = "#FF374B",
        # base_font = "Maven Pro"
      ),
      tabPanel(
        "Map Explorer",
        value = "mapPage",
        tagList(
          mapUI("map"),
          timelineUI("timeline")
        )
      )
    )
  )

  server <- function(input, output, session) {
    data <- mapServer("map")
    timelineServer("timeline", data)
  }

  shinyApp(ui, server)

}

#' @import shiny
addExternalResources <- function(){

  addResourcePath(
    'www', system.file('app/www', package = 'biodiversityApp')
  )

  tags$head(
    #shinyjs::useShinyjs(),
    tags$link(rel = "stylesheet", type="text/css", href="www/style.css")
  )

}

