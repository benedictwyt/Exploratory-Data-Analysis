#package ------------------------------------------------------------------------------
library(ggplot2)
library(tidyverse)
library(dplyr)

#data -----------------------------------------------------------------------------------
equip_loss_overall <- read.csv("russia_losses_equipment.csv")

refined_data <- select(equip_loss_overall, date, APC)

refined_data <- mutate(refined_data,new_monthly_loss = refined_data$APC 
                       - lag(APC, k = 1, order_by = date))
refined_data$new_monthly_loss[1] <- refined_data$APC[1]

refined_data$month_of_the_war <- as.numeric(format(as.Date(refined_data$date),'%m'))

refined_data <- summarise(group_by(refined_data, month_of_the_war), new_monthly_loss = sum(new_monthly_loss))

refined_data <- mutate(refined_data, fraction = new_monthly_loss / sum(new_monthly_loss))

refined_data$ymax = cumsum(refined_data$fraction)

refined_data$ymin = c(0, head(refined_data$ymax, n=-1))

refined_data <- mutate(refined_data, month_of_the_war = as.character(month_of_the_war))
#chart-------------------------------------------------------------------------------------
chart_3 <- 
  ggplot(refined_data, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=month_of_the_war)) +
  geom_rect() +
  coord_polar(theta="y") + 
  ggtitle("The Percentage of Loss APC during each Months of the War") +
  xlim(c(2, 4))