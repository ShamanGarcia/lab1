library(ggplot2)
library(sf)
library(tidyverse)

boulder <- st_read("BoulderSocialMedia.shp")

boulder

#plot 1 
ggplot() +
  geom_sf(data =boulder,
          fill = NA, alpha = .2) +
  theme_bw()
#plot 2
boulder = st_transform(boulder, 26753) 
ggplot() +
  geom_sf(data =boulder,
          fill = NA, alpha = .2) +
  theme_bw()
#plot 3
ggplot() +
  geom_sf(data =boulder, aes(color=PT_Elev),
          fill = NA, alpha = .2) +
  theme_bw()
#plot 4
ggplot() +
  geom_sf(data =boulder, aes(color=PT_Elev),
          fill = NA, alpha = .2) +
  scale_colour_gradientn(colours = terrain.colors(10)) +  
  theme_bw()
#plot 5
install.packages(dplyer)
library(dplyer)
boulder %>%
  mutate(high_elev = ifelse(PT_Elev >= 2200, TRUE, FALSE))%>% 
  ggplot() +
  geom_sf(aes(color=high_elev),
          fill = NA, alpha = .2)  +  
  theme_bw()
#plot 6
#library(dplyer)
boulder %>%
  mutate(high_elev = ifelse(PT_Elev >= 2200, TRUE, FALSE))%>% 
  ggplot() +
  geom_sf(aes(color=high_elev),
          fill = NA, alpha = .2)  +  
  theme_bw()
#plot 7
boulder %>%
  filter(DB ==  'Pano' | DB == 'Flickr') %>%
  ggplot(aes(x=DB, y=Street_dis)) + 
  geom_boxplot()
#plot 8

library(sf)
library(ggspatial)
library(viridis)
magma(10)

boulder <- st_read("BoulderSocialMedia.shp")

#plot1
ggplot() +
  geom_sf(data = boulder, aes(color=PT_Elev),
          fill = NA, alpha = .2) + 
  scale_colour_gradientn(colours = magma(10))

summary(boulder$DB)

p <- ggplot() +
  annotation_spatial(boulder) +
  layer_spatial(boulder, aes(col = DB))
p + scale_color_brewer(palette = "Dark2")

library(tmap)
#plot 1
## Add the data - these are specific to the vector or raster
tm_shape(boulder) + 
  ## which variable, is there a class interval, palette, and other options
  tm_symbols(col='PT_Elev', 
             style='quantile', 
             palette = 'YlOrRd',
             border.lwd = NA,
             size = 0.1)

#plot2
## here we are using a simple dataset of the world 
# tmap_mode("plot")
data("World")
tm_shape(World) +
  tm_polygons("gdp_cap_est", style='quantile', legend.title = "GDP Per Capita Estimate")

## the view mode creates an interactive map
tmap_mode("view")

tm_shape(World) +
  tm_polygons("gdp_cap_est", style='quantile', legend.title = "GDP Per Capita Estimate")