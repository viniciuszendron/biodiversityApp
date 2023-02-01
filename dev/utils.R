# Utility development functions

# Document package
devtools::document()

# Test package
devtools::test()

# Load package in local environment
devtools::load_all()

# Run RCMDCHECK
devtools::check()

# Deploy application to shinyapps.io server
rsconnect::deployApp()
