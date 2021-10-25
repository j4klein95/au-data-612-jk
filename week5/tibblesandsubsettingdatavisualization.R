library(tidyverse)
library(nycflights13)
library(dplyr)
# Data Visualization Summary TIBBLES  SUBSETTING  CHAPTER 7

# Data Visualization Summary

# Investigation of a quantitative variable: a boxplot, histogram,
# summary command

iris
boxplot(iris$Sepal.Length)
hist(iris$Sepal.Length)
summary(iris$Sepal.Length)

# Investigation of a categorical variable:  levels , factor
levels(iris$Species)  # the different levels of the categorical
                      # varible

factor(iris$Species)  # the frequency of each level

iris%>%
  count(Species)      # the summary frequency of each level

# Investigation of a quantitative variable and a categorical variable:
# side by side boxplots

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Length))

# Investigation of a relationship between two quantitative variables: 
# scatter plot

ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width))



# Different types of bargraphs 

tribble(~Name,   ~Gender,  ~Age, ~Gradelevel, ~Examone, ~Examtwo,
        "Leon",   "Male",   18,      11,         72,      81,
        "Mary",   "Female", 17,      12,         82,      86,
        "Alice",  "Female", 18,      11,         77,      83,
        "Matthew","Male",   16,      11,         86,      80,
        "Rene",   "Female", 17,      11,         80,      91
) -> StudentData
StudentData

# basic bar graph (counts)

ggplot(data = StudentData) +  
  geom_bar(mapping = aes(x = Gender, fill = Gender))


# basic bar graph (categorical and quantitative variable pairings)

ggplot(data = StudentData) +  
  geom_bar(mapping = aes(x = Name, y = Examone, fill = Name),
           stat = "identity")


# same bar graph with lables

ggplot(data = StudentData) +  
  geom_bar(mapping = aes(x = Name, y = Examone, fill = Name),
           stat = "identity") +
  geom_text(aes(x = Name, y = Examone, label = Examone), vjust = 2,
            size = 5, color = "darkred")


#Investigation of a relationship between two categorical variables:

diamonds

# Lets investigate a relationship between the variables cut and color.
# Both are categorical.

# method 1 use the ggplot coding chunk;  geom_count command
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))

# method 2 use the command count with dplyr
diamonds%>%
  count(color, cut)

# method 3 create a tile visualization

diamonds %>%
  count(color, cut) %>%
  ggplot(mapping = aes(x = color, y = cut)) +
           geom_tile(mapping = aes(fill = n))

# TIBBLES  SUBSETTING

# Tibbles vs Regular Data Frames

# How can you tell if an object is a tibble? 
# (Hint: try printing mtcars, which is a regular data frame).

 mtcars

# Generally, a tibble is a data set representation characterized by the
# display of the first ten or fewer rows and all of the variables that
# can be displayed in the console.
 
# Regarding mtcars, we can use r code to determine if mt cars is a tibble
# or not.
 
is_tibble(mtcars)

# mt cars as constructed is not a tibble, let's convert mtcars to a 
# tibble.

as_tibble(mtcars)

# Let's use r code to determine if the data sets diamonds and flights are
# tibbles.

is_tibble(diamonds)

diamonds

is_tibble(flights)

flights

# Recall that we converted mtcars to a tibble using as_tbble.  Now Use r
# coding to confirm that the converted mtcars is indeed a tibble.


is_tibble (as_tibble(mtcars))


# Now we practice creating tibbles

# Example 1
# Create a tibble of three columns; one has positive integers 1 to 5
# inclusive, another has all 1's, and for the third, each x value is
# raised to a power of 2 and the result is added to the value for y.


tibble(
  x = 1:5,
  y = 1,
  z = x^2 + y
)

# Example 2

# Create a tibble of 4 columns. The first column (a) has even integers 
# 2 thru 20, the second column (b) contains (a) values divided by 4,
# the third column (c) has the value 5 for each observational row, the 
# fourth column has the difference between columns (c) and (b), 
# and the last column (e) has the value k for each observational row.

tibble(
  a = 2*(1:10),
  b = a/4,
  c = 5,
  d = c - b,
  e = "k"
)


# It is possible for a tibble to have column names that are not valid
# R variable names?  You should surround these variables with back ticks
# `

# Example
# Let's suppose one column name is :: and it contains integers 1 thru 10
# 1:10. The other column name is 350 and it contains the letter b for
# all observational rows.

tibble(
  `::` = 1:10,
  `350` = "b"
)
  
# Another way to create a data table is with tribble()

# Example
# Create a tibble that shows the state and population for the
# three cities  Baltimore, Philadelphia, and Atlanta.

tribble(
~City,             ~State,                 ~Populatin,
"Baltimore",        "Maryland",            619497,       
"Philadelphia",     "Pennsylvania",        1581000,
"Atlanta",          "Georgia",             486290
)

# Lets Take another look at the data set mpg.  Is mpg a tibble ?

is_tibble(mpg)

# The result should be true. Lets confirm that it is true.
mpg

# Note that a maximum of 10 rows were generated.

# How can we produce more rows?

mpg%>%
  print(n=30)


# How to convert a tibble to a regular data frame
#  Remember that diamonds is a tibble

diamonds

# Remember that diamonds is tibble

is_tibble(diamonds)

# Let's convert diamonds to a regular data frame
as.data.frame(diamonds)

# Let's exam mtcars

mtcars

is.data.frame(mtcars)


is_tibble(mtcars)

# SUBSETTING  (Extracting variables from a data table)

# First let's explore the functions rnorm and runif
# rnorm :  randomly selecting numbers from a normal distribution


# Example1
#Let's randomly generate 10 numbers from a normal distribution that has
# mean of 0 and a standard deviation of 1
rnorm(10, mean = 0, sd = 1) 

# or

rnorm(10)

# Example 2

# Let's randomly generate 10 numbers from a normal distribution that has
# a mean of 24 and a standard deviation 3.


rnorm(10, mean = 24, sd = 3)

# runif : is used to generate  random numbers that lie between a given 
# minimum and maximum. 

#Example 3

# Now let's randomly generate 10 numbers between 0 and 1


runif(10, min = 0 , max = 1)

# Now let's randomly generate 10 numbers beween 5 and 15

runif(10, min = 5 , max = 15)

# If you do not indicate a minimum or a maximum, the defaults are
# minimum = 0 and maximum = 1.

runif(10)

# or

runif(10, min = 0 , max = 1)


# Now to Susetting

# Consider the following tibble

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
df


# Let's subset for x from df

# method 1  Use of  $
df$x

# Let's subset for y from df
df$y

# Let's consider the data table mtcars
mtcars

# Let's subset for mpg from mtcars

mtcars$mpg

# method 2  Use of double brackets  [[ ]]

df[["x"]]  # df$x gives the same result

df[["y"]]  # df$y gives the same result

mtcars[["mpg"]]  # mtcars$mpg gives the same result

# Let's now subset by position

df

df[[1]]   # since the x variable is first (from left to right) we will get all
          # of the x values


df[[2]]   # since the y variable is second (from left to right) we will get all
          # of the y values

# for which variable will all values be produced for the following
# code?
mtcars[[3]]

# Example 4

# More Susetting

# Let's create a data table by modifying mpg.

mpg%>%
select(manufacturer ,model, hwy)%>%
filter(hwy>34) -> ghwym
ghwym

ghwym

# Subset by name (using the $ sign)
ghwym$model

# Subset by name (using double brackets)
ghwym[["model"]]

# Subset by position (using double brackets)
ghwym[[2]]


ghwym[[3]]




q()
y


