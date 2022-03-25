# Challenge 1 - Basic Data Wrangling with LPI Bird Data

## Summary ----

# curlew.R visualize the curlew population trend from 1970s to 1990s in the U.K. 
# using Living Planet Index (LPI) data.  The current script is an improved version of 
# 'DS_starter.R' where codes are written more concise and script is formatted better.

# Edited by David Du (x.du-17@sms.ed.ac.uk)
# Oct-12-2021  

## Work flow ----

# 1. Import raw data 
# 2. Clean data: convert data to long format, remove NAs
# 3. Manipulate data: take only curlew population in the U.K., create variables
#    'scalepop', 'duration', and select only observations with duration greater
#    than 15 years.
# 4. Graph curlew populations trend in U.K. and map the population.
# 5. Export graphs


## Libraries ----
library(tidyverse)  # contains 'dplyr' and 'ggplot2' for data wrangling and graphing respectively
library(ggthemes)  # contains functions to customize graphs from ggplot
library(gridExtra)  # used to arrange grid based plots AKA our map


## 1. Import raw data from csv ----
LPI_raw <- read.csv("raw_data/LPI_birds.csv")  # read LPI bird observation
site_coords <- read.csv("raw_data/site_coords.csv")  # coordinates for bird observations

str(LPI_raw)  # see all column names, data type, first few data entries
str(site_coords)


## 2. Clean data: convert data to long format and select relevant variables ----

# Reshape data into long format, abundance and year in 1 col
LPI_long <- gather(LPI_raw, "year", "pop", 25:69)

# Remove non-finite and NAs in 'pop'
LPI_long <- LPI_long %>% 
                filter(is.finite(pop)) %>%  # keep only observations with finite values
                mutate(year = parse_number(year)) %>%  # turn all year into numeric values
                select(id, Common.Name, Country.list, year, pop)  # select relevant columns


## 3. Manipulate data ----

# Create data.frame 'curlew' which contains most relevant data for plotting
curlew <- LPI_long %>%
                filter(Common.Name == "Eurasian curlew") %>%  # keep only curlew observations
                filter(Country.list == "United Kingdom") %>%  # keep only observations done in U.K>
                group_by(id) %>%  # create internal grouping by 'id'
                mutate(duration = max(year) - min(year)) %>%  # create new variable "duration" as length of observation of each id
                mutate(scalepop = (pop - min(pop)) / (max(pop) - min(pop))) %>%  # create new variable "scalepop"
                filter(duration > 15)  # keep only observations with greater than 15 years of duration
        
      
## 4. Graph curlew populations trend in U.K and map the population ---- 

# Create trend line of scaled population of Eurasian curlew in U.K.
(fig_1 <- ggplot(curlew, aes(x = year, y = scalepop, group = id)) +  # graph scale pop over years
         geom_line(aes(color = Country.list)) +  # add line to plot, moved color = ... to have points as diff color
         geom_point() +  # add points to trend line
         ylab("Scaled population") +  # add y-axis title
         xlab("Year") +  # add x-axis title
         theme(legend.position = "bottom") +  # position legends at the bottom
         labs(title = "Eurasian curlew population trend") +  # add title to chart
         labs(color = "Country") +  # rename legend title
         scale_color_manual(values = c("skyblue1")) +  # more on ggplot colors at http://sape.inf.usi.ch/quick-reference/ggplot2/colour
         theme(plot.title = element_text(size = 15, hjust = 0.5)))  # adjust title size and position to middle

# Merge 'curlew' with 'site coordinates of observation
curlew <- left_join(curlew, site_coords, by = "id")  # add coordinates of observation to curlew, join by "id"

# Create map illustrating the location of observation and species of observation
(fig_2 <- ggplot(curlew, aes(x = Decimal.Longitude, y = Decimal.Latitude, colour = Country.list)) +  # set x and y input as longitude and latitude respectively
         borders("world", colour = "gray40", fill = "gray75", size = 0.3) +  
         coord_cartesian(xlim = c(-10, 35), ylim = c(30, 70)) +  # scale coordinates of the graph
         theme_map() + geom_point(size = 4) + theme(legend.position = "none") +  
         theme(plot.title = element_text(size = 15, hjust = 0.5)) +
         scale_color_manual(values = c("skyblue1")) +  # change color to my favorite color
         labs(title = "Location of observations"))


## 5. Save graph ----

# Save 'fig_1' and 'fig_2'
ggsave(filename = "figures/curlew_trend.pdf", plot = fig_1)
ggsave(filename = "figures/site.pdf", plot = fig_2)

# Make a panel of the two graphs
(fig_3 <- grid.arrange(fig_1, fig_2, ncol = 2))  

# Saves the combined plot
ggsave(filename = "figures/curlew_site.pdf", plot = fig_3)  

# nice and tidy