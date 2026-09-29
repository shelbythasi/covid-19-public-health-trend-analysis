# ===== Q5: Recreate data =====
library(ggplot2)
library(dplyr)

df_2020 <- read.csv("2020 Cases only_RS.csv")
df_2021 <- read.csv("2021 Cases only_RS.csv")

df_2020_proc <- subset(df_2020, 
                       select = -c(OBJECTID, Age_group, Case_, Case1, ChartDate))

names(df_2020_proc)[names(df_2020_proc) == "ObjectId2"] <- "ObjectId"

df_2021_proc <- subset(df_2021, 
                       select = -c(Age_group, Case_, Case1, ChartDate))

df_all <- rbind(df_2020_proc, df_2021_proc)

df_all$Date <- as.Date(df_all$EventDate, "%m/%d/%Y")

# ===== Q6: 2x2 visualization =====
df_q6 <- df_all %>%
  filter(County %in% c("Suwannee", "Monroe", "Hardee", "Walton"))

df_q6_summary <- df_q6 %>%
  group_by(County, Date) %>%
  summarise(Daily_Cases = n(), .groups = "drop")

df_q6_summary$County <- factor(df_q6_summary$County,
                               levels = c("Suwannee", "Monroe",
                                          "Hardee", "Walton"))

ggplot(df_q6_summary, aes(x = Date, y = Daily_Cases)) +
  geom_line(color = "red")+
  facet_wrap(~County, nrow = 2) +
  labs(title = "Daily COVID Cases by County",
       x = "Date",
       y = "Number of Cases")

# ===== Tampa Bay County Comparison =====
df_q6 <- df_all %>%
  filter(County %in% c("Hillsborough", "Pinellas", "Pasco"))

df_q6_summary <- df_q6 %>%
  group_by(County, Date) %>%
  summarise(Daily_Cases = n(), .groups = "drop")

df_q6_summary$County <- factor(
  df_q6_summary$County,
  levels = c("Hillsborough", "Pinellas", "Pasco")
)

ggplot(df_q6_summary, aes(x = Date, y = Daily_Cases)) +
  geom_line(color = "red") +
  facet_wrap(~County, nrow = 3) +
  labs(
    title = "Daily COVID-19 Cases Across Tampa Bay Counties",
    x = "Date",
    y = "Number of Cases"
  )
