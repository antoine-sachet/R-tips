#' Introduction to lists
#' @author Antoine
#' @date 2018-12-14


# Lists intro --------------------------------------------------------------

# Different from vectors because they can contain different data types and have elements of any length
li <- list(1, 2)
class(li)

li <- list(1:10, c("hello", "world"), rep(1:3, each = 5))
length(li)
li # Note the double square brackets

# access an element with `[[` : this returns the element in this slot
# the element could be anything!
li[[1]]

# subset a list with `[`: this returns a list (subset of the big list)
li[1] # this is a list (of length 1) containing 1:10
li[1:2] # sublist with the 2 first slots
li[c(1, 3)] # sublist with slot 1 and 3


# Names -------------------------------------------------------------------

# lists are super useful to keep related information together!
# It is best to use names whenever possible

# Creates a list of 2 elements both names
soundout <- list(CEO = "David", COO = "Grace")
soundout # Note the names instead of [[1]] and [[2]]

# Three ways to check the CEO:
soundout[[1]] # but you need to know the CEO is in the first slot! Not practical
soundout[["CEO"]] # use the name instead
soundout$CEO # Shortcut

# Programmatic access to a slot
role <- "COO"
soundout$role # there is no element called "role"
soundout[["role"]] # equivalent to the previous line
# Note that NULL was returned 
soundout[[role]] 

# Add a new element
soundout$analyst <- "Chloe"

# Create an empty list and add elements as needed
newli <- list()
newli$first <- "first element"

# Erase an element
newli$first <- NULL

# Name manipulation
# check names
names(soundout) 

# change names (capital A to Analyst) (rarely needed)
names(soundout) <- c("CEO", "COO", "Analyst")
soundout


# Use case of lists -------------------------------------------------------


# I mostly use lists to structure the data which is useful because:
# - it keeps the environment tidy
# - it makes your code easier to write, read and maintain, because 
#   if you use good names it is more obvious wjat you are doing
# - it makes it easy to find things (esp. with autocompletion)
# - it makes it easy to write more general functions

# An example:
# Keep in mind lists can contain anything: strings, numeric values, other strings...
soundout <- list(
  name = "SoundOut",
  capital = 1e6, # shortcut for 1 million
  employees = list(CEO = "David", COO = "Grace", 
                   Analyst = "Chloe", ClientSupport = "Tiff"),
  employee_of_the_year = "Antoine"
  )

company_summary <- function(company) {
  capital_pretty <- scales::dollar(company$capital, prefix = "£")
  out <- paste0("Company: ", company$name, "\n", 
        "Capital: ", capital_pretty, "\n",
        "Employees: ", length(company$employees))
  cat(out)
}

company_summary(soundout)

# Can be reused on a similar list
google <- list(
  name = "Google",
  NYSE_tick = "ABC",
  capital = 5e9,
  employees = 1:1000
)

company_summary(google)

# If this was real data I would actually have alist with all the companies!
companies <- list(google = google,
                  soundout = soundout)
# Easier to keep track of them!
length(companies)
company_summary(companies$soundout)

# When lists become big, it is impractical to print them
# Use str to get the gist of the structure
str(companies)
str(companies, max.level = 1)
str(companies, max.level = 2)
str(companies, max.level = 3)


# Looping on a list -------------------------------------------------------

# Explicit for loop:
for(comp in companies) {
  # Note the curvy brackets to create a block of code
  company_summary(comp)
  cat("\n\n")
}

# best avoided because it takes 3 lines and pollutes the environment
# by creating the "comp" variable

# Use implicit loops instead!


# Implicit loops / apply family -------------------------------------------

# Typically when we loop we want to do something to all elements of a list
# The trick is to write a function that does the something, and APPLY it to the list

# list-apply = lapply
# Takes a list and returns a list. Equivalent to Map.
lapply(companies, function(c) length(c$employees))

# simplify-apply = sapply
# Take a list and returns either a list or a vector/matrix if possible
n_employees <- sapply(companies, function(c) length(c$employees))
class(n_employees)


# Operations on list ------------------------------------------------------
# TBH I don't think I ever use those

# Turn a list into a vector (very rarely needed since we have sapply)
li <- list(1, 2, 3)
simplify2array(li)
unlist(li)

# Unlist recursively simplify the list
li2 <- list(a = 1:10, b = 2:5)
li2
simplify2array(li2) # doesn't do anything since cannot be simplified
unlist(li2) # flattens all sublists to make one big vector. 


# In practice -------------------------------------------------------------

# Data.frame is the go-to structure for tabular data
# For the rest, it often makes sense to use a list.

# For example, I often have a global list called conf which contains
# any configuration parameters needed (e.g. database credentials)

# I also often put related data.frames in a list. For example,
# if I have item data and both a training set and a test set, 
# I will probably have a list called `items` with sublists
# items$train for the training data, items$test for the test data

