# Visualizing_Curlew_Pop

### Info

Name: David Du

Email: x.du-17@sms.ed.ac.uk

Date: October 21st, 2021

### Summary

This repository contains files associated with Challenge 1 of Data Science for EES students.  This project involves coding etiquette and basic data wrangling.  Overall, I make code lines from ```DS_starter.R``` more concise using the pipline operator ```%``` and basic functions from ```dplyr``` package.  I also learned basic formatting of codes to create graphs and maps from ```ggplot2``` and how to customize titles, legends, and axis.  


```curlew.R``` is the main R script of this project takes data from the Living Planet Index ([LPI](https://livingplanetindex.org/home/index)) database and graph out trends of observed Eurasian Curlew population in the U.K. from the 70s to the 90s.  


It is important to mention that Hayward Wong contributed to this repo by providing comments on coding concision and formating.  Thanks Hayward!

### Files

| File name | Description |
| ---- | ---- |
```README.md``` | Basic info on the purpose of this repository, what it contains, and what it achieves
```challenge_1_instructions.md``` | Instruction of this challenge created by course organizers from Coding Club
```DS_starter.R``` | original R script that needed to be made more concise and organized
```curlew.R``` | a more concise version of ```DS_starter.R```, takes ```LPI_birds.csv``` and ```site_coords.csv``` to visualize Eurasian curlew trends in U.K.
```raw_data/LPI_birds.csv``` | csv file containing observation of bird data from LPI
```raw_data/site_coords.csv``` | csv file containing coordinates of observations for LPI_birds.csv
```figures/curlew_trend.pdf``` | pdf file visualizing curlew population in the U.K. as a trend line
```figures/sites.pdf``` | pdf file showing location of curlew observations
```figures/curlew_site.pdf``` | pdf file combining the above two graph
