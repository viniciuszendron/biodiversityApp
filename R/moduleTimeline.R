
#' @import shiny
timelineUI <- function(id) {
  ns <- NS(id)
  tagList(
    div(
      class = "timeline_bottom",
      timevis::timevisOutput(NS(id, "timeline"), width = "100%", height = "100%")
    )
  )
}

#' @import shiny
timelineServer <- function(id, data) {

  stopifnot(is.reactive(data))

  moduleServer(id, function(input, output, session) {
    output$timeline <- timevis::renderTimevis({
      timeline_data <- data() |>
        dplyr::mutate(start = eventDate, content = catalogNumber, id = id) |>
        dplyr::select(start, content, id)

      timevis::timevis(timeline_data, fit = TRUE,
                       options = list(editable = FALSE,
                                      height = "123px",
                                      locale = "en")
                       )
    })
  })

}
