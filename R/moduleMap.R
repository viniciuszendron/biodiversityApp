
#' @import shiny
mapUI <- function(id) {
  ns <- NS(id)

  tagList(
    div(
      class = "outer",
      leaflet::leafletOutput(NS(id, "leafMap"), height = "100%", width = "100%"),
      absolutePanel(
        id = NS(id, "floatbar"), class = "floatbar", fixed = TRUE, draggable = TRUE,
        top = 80, left = "auto", right = 20, bottom = "auto", width = 425, height = "auto",
        h3("Biodiversity Exploration"),
        shinyWidgets::radioGroupButtons(
          inputId = NS(id, "filterVar"),
          label = "Search species by",
          choices = c("Common Name" = "vernacularName", "Scientific Name" = "scientificName"),
          size = "sm",
          justified = TRUE
        ),
        selectInput(NS(id, "searchSpecies"), label = NULL,
                    choices = NULL, width = "100%"),
        div(tableOutput(NS(id, "selectedData")), class = "table_details")
      )
    )
  )
}

#' @import shiny
mapServer <- function(id) {

  moduleServer(id, function(input, output, session) {

    # Get data for the selected species
    data <- reactive({
      biodiversityPL |>
        dplyr::filter(!!as.symbol(input$filterVar) == input$searchSpecies)
    })

    # Create list with species according to filterVar
    choices <- reactive({
      req(input$filterVar)
      split(biodiversityPL[[input$filterVar]], biodiversityPL$kingdom) |>
        lapply(X = _, FUN = \(x) sort(unique(x)))
    })

    # Use server-side selectizeInput and update choices according to filterVar
    observe({
      req(input$filterVar)
      default <- ifelse(input$filterVar == "scientificName", "Coenagrion puella", "Azure Bluet")
      updateSelectizeInput(session, 'searchSpecies', choices = choices(),
                           server = TRUE, selected = default)
    })

    # Render map for the first time
    output$leafMap <- leaflet::renderLeaflet({

      tiles <- c("Esri World Topo Map" = "Esri.WorldTopoMap", "Esri World Imagery" = "Esri.WorldImagery",
                 "Esri World Street Map" = "Esri.WorldStreetMap", "Esri DeLorme" = "Esri.DeLorme",
                 "OpenStreetMap" = "OpenStreetMap", "OpenTopoMap" = "OpenTopoMap",
                 "Stamen Terrain" = "Stamen.Terrain")

      leaflet::leaflet() |>
        addMultipleProviderTiles(provider = tiles) |>
        leaflet::setView(lng = 19.25, lat = 52.20, zoom = 6) |>
        leaflet.extras::addFullscreenControl() |>
        leaflet::addScaleBar(position = "bottomleft") |>
        leaflet::addLayersControl(
          baseGroups = names(tiles),
          position = "topleft",
          options = leaflet::layersControlOptions(collapsed = TRUE))

    })

    # Update Map when reactive data updates
    observe({

      df <- data()

      if (nrow(df) == 0) return()

      mapData <- createPopupData(df)

      leaflet::leafletProxy("leafMap", data = mapData) |>
        leaflet::clearPopups() |>
        leaflet::clearMarkerClusters() |>
        leaflet::setView(lng = 19.25, lat = 52.20, zoom = 6) |>
        leaflet::addCircleMarkers(
          label = ~lapply(label, HTML),
          labelOptions = leaflet::labelOptions(className = "leaflet_hover_pop"),
          popup = ~lapply(label, HTML),
          lng = ~longitudeDecimal, lat = ~latitudeDecimal,
          clusterOptions = leaflet::markerClusterOptions()
        )

    })

    # Table with details of the species selected
    output$selectedData <- renderTable(colnames = FALSE, width = "100%",
                                       striped = TRUE, spacing = "xs", bordered = TRUE, {

      req(data)

      createInfoTable(data())

    })

    return(data)

  })

}

# Iterate addProviderTiles function
addMultipleProviderTiles <- function(map, provider, group = names(provider)) {
  for (i in seq_along(provider)) {
    map <- leaflet::addProviderTiles(map, provider[[i]], group = group[[i]])
  }
  return(map)
}

# Create table to show species details
createInfoTable <- function(speciesData) {
  dataSpecies <- speciesData |>
    dplyr::select(scientificName, vernacularName, family, kingdom, individualCount) |>
    dplyr::mutate(family = stringr::str_to_title(stringr::str_replace_all(family, "_", " ")))
  data.frame(
    Name = c(
      "Scientific Name",
      "Vernacular Name",
      "Family",
      "Kingdom",
      "Registers",
      "Observations"
    ),
    Info = c(
      paste0(unique(dataSpecies$scientificName), collapse = ", "),
      paste0(unique(dataSpecies$vernacularName), collapse = ", "),
      paste0(unique(dataSpecies$family), collapse = ", "),
      paste0(unique(dataSpecies$kingdom), collapse = ", "),
      nrow(dataSpecies),
      sum(dataSpecies$individualCount, na.rm = TRUE)
    )
  )
}

# Create data.frame to be used in popups
createPopupData <- function(speciesData) {
  speciesData |>
    # dplyr::rowwise() |>
    dplyr::mutate(
      locality = stringr::str_replace_all(locality, "Poland - ", ""),
      mediaAccessURI = ifelse(is.na(mediaAccessURI), "www/noimg.png", mediaAccessURI),
      lifeStage = stringr::str_to_title(lifeStage),
      sex = stringr::str_to_title(sex)
    ) |>
    dplyr::mutate(
      label = paste0(
        # collapse = "<br/>",
        "<p><b>", catalogNumber, "</b></p>",
        "<img class=\"popup_img\" src=\"", mediaAccessURI, "\" alt=\"", mediaRightsHolder, "\">",
        "<p></p>",
        "<p><b>Location: </b>", locality, "</p>",
        "<p><b>Date: </b>", eventDate, "</p>",
        "<p><b>Observations: </b>", individualCount, "</p>",
        "<p><b>Life Stage: </b>", lifeStage, "</p>",
        "<p><b>Sex: </b>", sex, "</p>",
        "<a href=\"", references, "\" target=\"_blank\">More information</a>"
      )
    )
}

