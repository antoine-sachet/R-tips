#' Introduction to dplyr
#' @author Antoine
#' @date 2018-12-17

library("dplyr")
# Be careful: name conflicts happen
# Especially with stats::filter and MASS::select
# Super annoying when that happens


# Piping ------------------------------------------------------------------

# "Piping" means chaining operations in the order in which they happen
# This makes code more readable and easier to validate
# It is a good alternative to introducing temporary / intermediate variables
# Use only when reasonable though

# The idea is that whatever is piped into a function becomes its first argument:
# foo(x) is the same as x %>% foo
# h(g(f(x))) is x %>% f %>% g %>% h

# Also works with argument
# foo(x, ...) is x %>% foo(...)

# Piping really shines when calling lots of functions with arguments
# h(g(f(x, 2), T), digits=2) 
# becomes clearer:
# x %>% f(2) %>% g(T) %>% h(digits=T)

# EXAMPLE 1 - RMSE
# A somewhat contrived example (would not use piping in real life):
N <- 50
x <- runif(n = N, 0, 100)
y <- x + rnorm(N, mean=0, sd=20)
plot(x, y)

# RMSE without piping
sqrt(sum((x-y)^2))

# RMSE with piping (%>%)
(x-y)^2 %>%
  sum %>%
  sqrt

# EXAMPLE 2 - complicated print
# Another somewhat less contrived example (but still probably would not use piping):
perc <- 0.2354567
# Printing the percentage
print(paste0("This is the percentage: ", round(100 * perc, digits=1), "%"))

# With piping
perc %>%
{100 * .} %>% # using an expression within {} where . is the variable
  round(digits=1) %>% # a function with a second argument
  {paste0("This is the percentage: ", ., "%")} %>% # another expression
  print


# Intro to dplyr ----------------------------------------------------------

# Dplyr introduces functions (in the form of verbs) to manipulate data frames
# All dplyr functions work nicely with piping

# Transaction dataset from a big european online retailer RDS is a compressed
# binary format useful to save R data for later use Saves the R data structure
# so no parsing is required: the object is loaded back into the session exactly
# as it was
transactions <- readr::read_rds("data/transactions_full.rds")

glimpse(transactions)


# Subsetting --------------------------------------------------------------

# filter rows
# select columns

transactions_damen <- 
  transactions %>%
  filter(cg1 == "Textil", cg2 == "Damen") %>% 
  select(sku, brand, starts_with("cg"), colour,
         activation_date, date, SOLD_ITEMS_BEF_RETURN, RETURNED_ITEMS)

# Note that dplyr does some dark magic (called non-standard evaluation)
# to allow us to give unquoted variables to dplyr functions

# Select helpers are very useful but only work in `select` or `vars`
?dplyr::select

# I mostly use starts_with, ends_with, matches and range selection
transactions %>%
  select(sku, brand, cg1:cg5, starts_with("NET"), ends_with("ITEMS")) %>%
  glimpse()

transactions %>%
  select(sku, BRAND = brand, matches("^cg[1-3]$"), contains("SALES")) %>%
  glimpse()


# Basic aggregation: counts -----------------------------------------------

# Counting # rows for each value of brand
transactions_damen %>%
  count(brand) 

# Use arrange to re-order rows
transactions_damen %>%
  count(brand) %>%
  arrange(desc(n))

# Can count more than one variables
transactions %>%
  count(cg1, cg2, cg3) %>%
  View()

# How many subcategories in shoes and textile?
unique(transactions$cg3) # ?

transactions %>%
  count(cg1, cg2, cg3) %>%
  count(cg1, cg2)

# Create new derived variables --------------------------------------------

transactions_damen <- transactions_damen %>% 
  mutate(only1 = 1) %>%
  mutate(NET_ITEMS = SOLD_ITEMS_BEF_RETURN - RETURNED_ITEMS,
         return_rate = RETURNED_ITEMS / SOLD_ITEMS_BEF_RETURN) %>% 
  glimpse()


# magrittr advanced piping

transactions_damen %<>% 
  mutate(only1 = 1) %>%
  mutate(NET_ITEMS = SOLD_ITEMS_BEF_RETURN - RETURNED_ITEMS,
         return_rate = RETURNED_ITEMS / SOLD_ITEMS_BEF_RETURN)

# Advanced aggregations ---------------------------------------------------
# Two verbs:
# - group_by to define groups (does not do anything except registering the groups)
# - summarise (or summarize) to perform aggregation for each group

# Summary function must returned single value per group!
# Mutation function must returned one value per row!

transactions_damen %>%
  summarise(average_weekly_return_rate = mean(return_rate, na.rm=T),
            overall_return_rate = sum(RETURNED_ITEMS) / sum(SOLD_ITEMS_BEF_RETURN))


transactions_damen %>%
  group_by(cg1, cg2, cg3) %>%
  summarise(average_weekly_return_rate = mean(return_rate, na.rm=T),
            overall_return_rate = sum(RETURNED_ITEMS) / sum(SOLD_ITEMS_BEF_RETURN)) %>%
  arrange(desc(overall_return_rate))

transactions_damen %>%
  group_by(brand) %>%
  summarise(average_weekly_return_rate = mean(return_rate, na.rm=T),
            overall_return_rate = sum(RETURNED_ITEMS) / sum(SOLD_ITEMS_BEF_RETURN)) %>%
  arrange(desc(overall_return_rate))

# Manual count (can be combined with other aggregations)
transactions_damen %>%
  group_by(cg1, cg2, cg3) %>%
  summarise(n = n())


# Advanced mutation -------------------------------------------------------

# Renaming
transactions_damen %>%
  mutate(always_one = only1) %>% 
  rename(only_one = only1) %>%
  glimpse()

# Mutate with group_by
# How to get proportion of cg2 by cg1?
transactions %>%
  count(cg1, cg2) %>%
  group_by(cg1) %>%
  mutate(prop = n / sum(n),
         prop_pretty = scales::percent(prop))
  


# Challenge ---------------------------------------------------------------

#' How important are discounts? 
#' Do items sell more when discounted?

transactions %>%
  select(-discount_rate, -is_black_price) %>%
  sample_frac(0.01) %>%
  mutate(discount_rate = NET_DISCOUNT / NET_SALES_BEF_DISCOUNT) %>%
  mutate(is_black_price = discount_rate < 0.02) %>%
  group_by(cg1, is_black_price) %>%
  summarise(total_sold = sum(SOLD_ITEMS_BEF_RETURN - RETURNED_ITEMS),
            n_weeks = n()) %>%
  mutate(prop_sold = total_sold / sum(total_sold))

transactions %>%
  select(-discount_rate, -is_black_price) %>%
  # sample_frac is useful to try out the pipeline on a smaller subset of data
  # another option is sample_n to sample exactly N rows at random
  # This can be combined with group_by to take a random sample in each group
  # sample_frac(0.01) %>%
  mutate(discount_rate = NET_DISCOUNT / NET_SALES_BEF_DISCOUNT) %>%
  mutate(is_black_price = ifelse(discount_rate < 0.02, "black-price", "discounted")) %>%
  group_by(cg1, sku, is_black_price) %>%
  summarise(total_sold = sum(SOLD_ITEMS_BEF_RETURN - RETURNED_ITEMS),
            n_weeks = n()) %>%
  mutate(prop_sold = total_sold / sum(total_sold)) %>%
  group_by(cg1, is_black_price) %>%
  summarise(mean(prop_sold, na.rm=T))
