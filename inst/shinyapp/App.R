# Detect run mode ---------------------------------------------------------
xena.runMode <- getOption("xena.runMode", default = "client")
message("Run mode:", xena.runMode)

# Load necessary packages ----------------------------------
message("Checking depedencies...")

library(pacman)
if (!requireNamespace("gganatogram")) {
  pacman::p_load(remotes)
  tryCatch(
    remotes::install_github("jespermaag/gganatogram"),
    error = function(e) {
      remotes::install_git("https://gitee.com/XenaShiny/gganatogram")
    }
  )
}

pacman::p_load(
    purrr,
    tidyr,
    stringr,
    magrittr,
    dplyr,
    ggplot2,
    ggpubr,
    plotly,
    UCSCXenaTools,
    UCSCXenaShiny,
    shiny,
    shinyBS,
    shinyjs,
    shinyWidgets,
    shinyalert,
    shinyFiles,
    survival,
    survminer,
    ezcox,
    waiter,
    colourpicker,
    DT,
    fs,
    gganatogram
)

message("Starting...")

# Put data here -----------------------------------------------------------
data("XenaData", package = "UCSCXenaTools", envir = environment())
xena_table <- XenaData[, c(
  "XenaDatasets", "XenaHostNames", "XenaCohorts",
  "SampleCount", "DataSubtype", "Label", "Unit"
)]
xena_table$SampleCount <- as.integer(xena_table$SampleCount)
colnames(xena_table)[c(1:3)] <- c("Dataset ID", "Hub", "Cohort")

## data summary
Data_hubs_number <- length(unique(xena_table$Hub))
Cohorts_number <- length(unique(xena_table$Cohort))
Datasets_number <- length(unique(xena_table$`Dataset ID`))
Samples_number <- "~2,000,000"
Primary_sites_number <- "~37"
Data_subtypes_number <- "~45"
Xena_summary <- dplyr::group_by(xena_table, Hub) %>%
  dplyr::summarise(
    n_cohort = length(unique(.data$Cohort)),
    n_dataset = length(unique(.data$`Dataset ID`)), .groups = "drop")

# global color
mycolor <- c(RColorBrewer::brewer.pal(12, "Paired"))

# Put modules here --------------------------------------------------------
modules_path <- system.file("shinyapp", "modules", package = "UCSCXenaShiny", mustWork = TRUE)
modules_file <- dir(modules_path, pattern = "\\.R$", full.names = TRUE)
sapply(modules_file, function(x, y) source(x, local = y), y = environment())


# Put page UIs here -----------------------------------------------------
pages_path <- system.file("shinyapp", "ui", package = "UCSCXenaShiny", mustWork = TRUE)
pages_file <- dir(pages_path, pattern = "\\.R$", full.names = TRUE)
sapply(pages_file, function(x, y) source(x, local = y), y = environment())


# Obtain path to individual server code parts ----------------------------
server_file <- function(x) {
  server_path <- system.file("shinyapp", "server",
    package = "UCSCXenaShiny", mustWork = TRUE
  )
  file.path(server_path, x)
}



# UI part ----------------------------------------------------------------------
ui <- tagList(
  tags$head(tags$title("XenaShiny")),
  shinyjs::useShinyjs(),
  use_waiter(),
  navbarPage(
    title = div(
      img(src = "xena_shiny-logo_white.png", height = 49.6, style = "margin:-20px -15px -15px -15px")
    ),
    # inst/shinyapp/ui
    ui.page_home(),
    ui.page_repository(),
    ui.page_modules(),
    ui.page_pipelines(),
    ui.page_help(),
    ui.page_developers(),
    footer = ui.footer(),
    theme = shinythemes::shinytheme("cosmo")
  )
)

# Server Part ---------------------------------------------------------------
server <- function(input, output, session) {
  message("Shiny app run successfully! Enjoy it!\n")
  message("               --  Xena shiny team\n")

  # inst/shinyapp/server
  source(server_file("home.R"), local = TRUE)
  source(server_file("repository.R"), local = TRUE)
  source(server_file("modules.R"), local = TRUE)
  source(server_file("pipelines.R"), local = TRUE)
}

# Run web app -------------------------------------------------------------

shiny::shinyApp(
  ui = ui,
  server = server
)
