#Class example map
#plot2
## here we are using a simple dataset of the world 
# tmap_mode("plot")
library(ggplot2)
library(sf)
library(tidyverse)
library(tmap)
data("World")
tm_shape(World) +
  tm_polygons("gdp_cap_est", style='quantile', legend.title = "GDP Per Capita Estimate")

## the view mode creates an interactive map
tmap_mode("view")

# Personal Map
library(dplyr)
library(tmap)
library(sf)

data("World")

# Read borders CSV
borders <- st_read("borderfull.csv")

# Join world data with borders
world_joined <- left_join(World, borders, by = "name") %>%
  select(name, Number.of.Bordering.Countries, Bordering.countries) %>%
  mutate(
    # Set factor order for the legend
    Number.of.Bordering.Countries = factor(
      Number.of.Bordering.Countries,
      levels = c(1,2,3,4,5,6,7,8,9,10,11,14,NA),
      exclude = NULL
    ),
    # Add HTML line breaks for better popup readability
    Bordering.countries = gsub(" (?=[A-Z][a-z]+:)", "<br>", Bordering.countries, perl = TRUE)
  )

# Switch to interactive mode
tmap_mode("view")

# Create the map
tm_shape(world_joined) +
  tm_polygons(
    "Number.of.Bordering.Countries",
    style = "cat",
    palette = "Set1",
    title = "Number of Bordering Countries",
    colorNA = "grey90",
    textNA = "Missing",
    id = "name",
    popup.vars = c(
      "Number of Borders" = "Number.of.Bordering.Countries",
      "Bordering Countries" = "Bordering.countries"
    ),
    popup.format = list(html.escape = FALSE)
  ) +
  tm_layout(
    legend.position = c("right", "bottom"),
    legend.text.size = 0.6,    # shrink text
    legend.title.size = 0.8,   # shrink title
    legend.bg.alpha = 0.7      # slightly transparent background
  )
