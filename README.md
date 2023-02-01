
# Polish Biodiversity Exploration App

<!-- badges: start -->
[![version](https://img.shields.io/badge/version-1.0-green.svg)](https://semver.org)
[![CI-CD](https://github.com/viniciuszendron/biodiversityApp/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/viniciuszendron/biodiversityApp/actions/workflows/ci-cd.yml)
<!-- badges: end -->

## Overview 

This is a simple Shiny App to showcase Polish Biodiversity data. The app is deployed [here](https://zendron.shinyapps.io/biodiversityapp/)!

## Installation

You can install the development version of `biodiversityApp` like so:

``` r
if (!requireNamespace("remotes"))
  install.packages("remotes")
  
remotes::install_local(path = ".", 
                       repos = "http://cloud.r-project.org",
                       INSTALL_opts = c("--no-multiarch"))
```

## Starting the Application

To start the application, run the following command:

``` r
biodiversityApp::biodiversityApp()
```

## About the app

### Data used

The biodiversity data used in the app is from Global Biodiversity Information Facility. In the app, we are using only data from observations taken in Poland. To subset the dataset, we have used the `arrow` package in order to work with the data without loading it into the memory.

### App structure

The app has a simple layout, divided in three parts: header, central panel and timeline panel. The central panel contains the map (provided by the package `leaflet`) and the floating sidebar (draggable). User can select a desired species in a `selectInput` located in the sidebar. Next to it, user can change the source of `selectInput` between the common name (vernacularName) and the scientific name (scientificName). After a selection is made, a small table in the sidebar displays basic information about the species selected, and the map updates to show every observation made over the years for the selected species. The timeline panel also updates to display the same observations of the map in a timeline view.

The user has the option to change the base map among 7 different providers. The observations are shown as markers in the map, each one being interactive, where a mouse hover or a click on it displays a popup with information of that specific observation and also show the picture taken by the observer (if provided). A link to the reference page is provided in the popup.

The repository is hosted at GitHub and a CI/CD workflow is active, performing the `RCMDCHECK` and deploying the application to the [shinyapps.io](https://zendron.shinyapps.io/biodiversityapp/) server.

## Next steps

- Improve modularization;
- Include more Unit Tests and an End to End Test;
- UI/UX improvements (popups, timeline, map-timeline communication, Data Explorer Tab, ...);
- Implement support to global data (using `arrow`?).


