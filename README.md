# R training

An evolving collection of R tips and tricks. For a comprehensive introduction to R, I recommend https://r4ds.had.co.nz/.

## Recommended order:

* intro.R
* lists.R
* data.frames.R
* readr.R
* dplyr.R

## Intro to R

- Data types and structures
- Rstudio useful shortcuts and  functions
- (classes and function dispatch)
- Using git

## Data manipulation

- `dplyr`
- Joining datasets
- `readr`
- `magrittr`
- overview of other useful packages:
    * lubridate
    * tidyr
    * forcats

## Tips and tricks

- Reading (with `readxl`) and writing (with `openxls`) excel data
- Reshaping data with `tidyr`
- Better for loops with `foreach`
- Debugging code

## Machine learning with R

- Basics: lm and glm
- Fitting distributions with `fitdistrplus`
- Taking it to the next level with `caret`

## Plotting with ggplot2
- Basic plots, labelling, facetting
- Customising scales (x/y, color/fill)
- Advanced geoms

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

# References

The very best introduction to R and the tidyverse: https://r4ds.had.co.nz/


