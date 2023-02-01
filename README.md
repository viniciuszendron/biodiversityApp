
# Polish Biodiversity Exploration App

<!-- badges: start -->
[![version](https://img.shields.io/badge/version-1.0-green.svg)](https://semver.org)
[![CI-CD](https://github.com/viniciuszendron/biodiversityApp/actions/workflows/CI-CD.yaml/badge.svg)](https://github.com/viniciuszendron/biodiversityApp/actions/workflows/CI-CD.yaml)
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

--




## Next steps

- Improve modularization
- Include more Unit Tests and an End to End Test.
- UI/UX improvements (popups, timeline, map-timeline communication, Data Explorer Tab, ...).
- CI/CD through GitHub Actions.
- Implement support to global data (using `arrow`?).


