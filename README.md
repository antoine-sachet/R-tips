# R training

An evolving collection of R tips and tricks. For a comprehensive introduction to R, I recommend https://r4ds.had.co.nz/.

## Recommended order:

* intro.R
* lists.R
* data.frames.R
* readr.R
* dplyr.R

## Introduction 

- R Data types and structures
- Rstudio useful shortcuts and functions
- Using git (see https://guides.github.com/introduction/git-handbook/)
- Using git from Rstudio (see http://r-pkgs.had.co.nz/git.html or video https://resources.rstudio.com/wistia-rstudio-essentials-2/rstudioessentialsmanagingpart2-2)

For an in-depth introduction to Rstudio see https://resources.rstudio.com/


## Data manipulation

- `dplyr` (see https://r4ds.had.co.nz/transform.html)
- Joining datasets
- `readr` (see https://r4ds.had.co.nz/data-import.html)
- `magrittr`
- overview of other useful packages:
    * lubridate
    * tidyr (see https://r4ds.had.co.nz/tidy-data.html)
    * forcats (see https://r4ds.had.co.nz/factors.html or http://stat545.com/block029_factors.html)

## Tips and tricks

- Reading (with `readxl`) and writing (with `openxls`) excel data
- Reshaping data with `tidyr`
- Better for loops with `foreach`
- Debugging code
- classes and function dispatch

## Machine learning with R

- Basics: lm and glm
- Fitting distributions with `fitdistrplus`
- Taking it to the next level with `caret`

## Plotting with ggplot2
- Basic plots, labelling, facetting
- Customising scales (x/y, color/fill)
- Advanced geoms
- Comprehensive introduction: https://r4ds.had.co.nz/data-visualisation.html

## Web-apps with Shiny

- https://shiny.rstudio.com/tutorial/
- A collection of advanced shiny articles https://shiny.rstudio.com/articles/

# Packages needed

Installing all of them will take a long time.

```
install.packages("tidyverse")
install.packages("caret", dependencies = T)
install.packages("fitdistrplus")
install.package("openxlsx")
install.package("ggplot2", dependencies = T)
install.packages("Hmisc")
install.packages("foreach")
install.packages("doParallel")
install.packages("e1071")
```
