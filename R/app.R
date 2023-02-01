
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
      theme = bslib::bs_theme(version = "5"),
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
    tags$link(rel = "stylesheet", type="text/css", href="www/style.css")
  )

}

