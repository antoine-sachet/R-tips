#' Introduction to data.frames and tibbles
#' @author Antoine
#' @date 2018-12-14


# Introduction ------------------------------------------------------------

# Data.frames are ubiquitous in R
# They are used to hold tabular data (i.e. lie a SQL DB or excel)

# Rules: each column is a field and each row is an observation
# There are tons of illustrative data.frames available directly
# from the datasets package. Iris is a super classic dataset.

?iris # more info
iris <- datasets::iris
class(iris)
# Printing a data.frame prints it all
iris
# !!! Printing a big enough data.frame can crash your machine !!!

# Extract the first rows
head(iris)
head(iris, n = 10)
# (head also works on vectors and lists)

# Extract the last rows
tail(iris)
tail(iris, n=1)

# Exploring a data.frame --------------------------------------------------

# Loading the dplyr package which contains glimpse
library("dplyr")

glimpse(iris)
summary(iris)

View(iris)


# Basic data.frame operations ------------------------------------------------------

# A data.frame is basically a wrapper for a list of vector
# Where all the vectors have the same length
li <- list(a = 1:5, b=11:15)
li
df <- as.data.frame(li)
df

# Create a data.frame directly 
df <- data.frame(a = 1:5, 
                 b=11:15,  
                 c=letters[1:5])

# This means there is a lot in common between lists and data.frames

# Extract a column:
df[["a"]]
df$a

# Extract a column programmatically
col <- "b"
df$col # does not work: returns NULL
df[[col]]

# An extracted column is just a vector so we can do 
# all kinds of vector stuff with it
sum(df$a)
df$a ^ 2

# Create a new column
# MUST BE the same length as the others though
df$d <- rep(1, 6) # not the right length! Error
df$d <- rep(1, 5)

glimpse(df)

# Intro to tibbles -----------------------------------------------------------------

# Data.frames have flaws because R sometimes tries to be too clever
# These flaws are avoided by using tibbles instead of data.frames

# There is nothing special to do: 
# - `readr` functions to load data will load them in tibbles.
# - `dplyr` functions will always return a data.frame

# Loading dplyr library
# Not tidyverse functions use _ rather than . in function names
library("dplyr")

iris <- as_tibble(iris)

# printing a tibble just shows the first few columns and first few lines
# and never crashed your machine which is typically what you want.
iris

# There is no reason not to use tibbles everywhere instead of data.frames
# Whenever I mention data.frames I implicitly mean tibbles.

# Iris is still a data.frame so all data.frame functions will still work
# Iris has more than one class! It is also a 'tbl' = tibble.
class(iris)


# Data.table --------------------------------------------------------------

# FYI there is another package that expands data.frames
# It is called data.table and it is very good and very fast
# But I prefer dplyr and tibbles

# I find dplyr much more intuitive and easier to use, 
# while being more flexible and powerfule. 
# data.table is marginally faster though. 


