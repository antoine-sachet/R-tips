#' Introduction to data visualisation with ggplot2
#' @author Antoine
#' @date 2018-12-17

library("ggplot2")


# Intro to ggplot ---------------------------------------------------------

# GG = Grammar of Graphics
# The idea is:
# - A plot is described as successive layers (combined with +)
# - Each layer is parametrised by aesthetics (e.g. x, y, color) and parameters (e.g. position and stat)
#   (Most parameters and aesthetics have sensible default values)
# - Layers that draw something start with `geom_` (e.g. geom_point to make a scatterplot)
# - Plot actual data by providing data + mapping to aesthetics 


df <- transactions %>%
    filter(sku == sku[1:10])

# pass the data to ggplot
ggplot(df) 

# Points take: x, y, color, size, type, etc.
# Default values for all but x and y
ggplot(df)  + geom_point()

# Map data to x and y via `aes()`
ggplot(df) + geom_point(aes(x = date, y = RETURNED_ITEMS))

# It is common to use the same aes in mulitple layers
ggplot(df) + 
  geom_point(aes(x = date, y = RETURNED_ITEMS)) + 
  geom_line(aes(x = date, y = RETURNED_ITEMS))

# Aesthetics passed to ggplot are inherited by all layers
ggplot(df, aes(x = date, y = RETURNED_ITEMS, color=sku)) + 
  geom_point() + 
  geom_line()


# Facets ------------------------------------------------------------------
# Facetting layers start with `facet_`

ggplot(df, aes(x = date, y = RETURNED_ITEMS, color=brand)) + 
  geom_point() + 
  geom_line(aes(group=sku)) +
  facet_wrap(vars(cg1, cg2))


ggplot(df, aes(x = date, y = RETURNED_ITEMS, color=brand)) + 
  geom_point() + 
  geom_line() +
  facet_grid(cg1 ~ cg2) +
  theme_bw()



# Themes ------------------------------------------------------------------
# Prepared themes start with `theme_`
# I like theme_bw

ggplot(df, aes(x = date, y = RETURNED_ITEMS, color=brand)) + 
  geom_point() + 
  geom_line() +
  facet_wrap(vars(cg1, cg2)) +
  theme_bw()


# Labels ------------------------------------------------------------------

p <- ggplot(df, aes(x = date, y = RETURNED_ITEMS, color=brand)) + 
  geom_point() + 
  geom_line() +
  facet_wrap(vars(cg1, cg2)) +
  labs(x = NULL, 
       y = "# returned items",
       title = "Returned items by week",
       subtitle = "2017 transaction data")

p

# Save a plot with ggsave -------------------------------------------------
# Ideal to make sure all your plots have the same size!

ggsave("myplot.jpg", plot = p, width = 15, height = 10, units = "cm")



# Stat and position -------------------------------------------------------

ggplot(df) + geom_histogram(aes(x=date))

# Use `aes()` to map variables from the data
# Pass values OUTSIDE aes if set manually
ggplot(df) + 
  geom_histogram(aes(x=date), fill = "steelblue", color = "black")

# Otherwise ggplot will consider it part of the data a mapping!
ggplot(df) + 
  geom_histogram(aes(x=date, fill="steelblue"), color = "black")

# Note we have not provided y: geom_histogram computed y automatically!
# Not magic: geom_histogram uses stat_bin (which computes y) by default
# On the other hand geom_point uses stat_identity by default, which does not create any value.




# Scales control ----------------------------------------------------------



# Colour and fill scales --------------------------------------------------



