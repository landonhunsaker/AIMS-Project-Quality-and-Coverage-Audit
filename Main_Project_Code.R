library(tidyverse) ##used for visualization and tidy workflow
library(data.table)##used to assist reading csvs in
library(lubridate)##used for MD5 hash values

### Pulling all the CSVs
all_files <- list.files(path = "./extracted",pattern = "\\.csv$",full.names = TRUE,recursive = TRUE);length(all_files)
length(all_files) ##should be 1068

## Safeguard to remove duplicated files with unique MD5 Hash for each file.
MD5_CSVs <- tools::md5sum(all_files);length(MD5_CSVs)
duplicate_csvs = duplicated(MD5_CSVs)

all_files_nd <- all_files[duplicated(MD5_CSVs) == FALSE]; length(all_files_nd)

### Reading and concatenation:

data = list()
for (csv in unique(all_files_nd)){
  data[[csv]] = read.csv(csv)
}

df <- rbindlist(data, fill = TRUE, use.names = TRUE, idcol="source_file")
head(df,1000)
dim(df)

rm(data)

#############################################################################

### Begin Tidying: 

dim(df |> filter(is.na(datetime))) ## confirming all the obs have a date

## Creating a Year Column from the Character Date Column
df <- df |> mutate(
  datetime = ymd_hms(datetime)
)
df_year <- df |> mutate(
  Year = year(datetime)
) |> select(-year)
rm(df)

############## Great Plains Watersheds
####### Kings Creek

Kings_Creek_Konza_Prarie_GP <- df_year[grep("GP_KNZ", as.character(df_year$source_file), useBytes=TRUE),]

## Confirming only original Kings Creek Files were included.
length(unique(Kings_Creek_Konza_Prarie_GP$source_file))==length(all_files_nd[grep("GP_KNZ", all_files_nd)]) ## equal at 315

setdiff(unique(Kings_Creek_Konza_Prarie_GP$source_file), all_files_nd[grep("GP_KNZ", all_files_nd)]) ## 0

sum(table(Kings_Creek_Konza_Prarie_GP$source_file))==nrow(Kings_Creek_Konza_Prarie_GP) ## equal ~6250000

####### Shane Creek

Shane_Creek_Konza_Prarie_GP <- df_year[grep("GP_SHN", as.character(df_year$source_file), useBytes=TRUE),]

## Confirming only original Shane Creek Files were included.
length(unique(Shane_Creek_Konza_Prarie_GP$source_file))==length(all_files_nd[grep("GP_SHN", all_files_nd)]) ## equal at 56

setdiff(unique(Shane_Creek_Konza_Prarie_GP$source_file), all_files_nd[grep("GP_SHN", all_files_nd)]) ## 0

sum(table(Shane_Creek_Konza_Prarie_GP$source_file))==nrow(Shane_Creek_Konza_Prarie_GP) ## equal ~1100000

####### Young Meyer Ranch

Young_Meyer_Ranch_GP <- df_year[grep("GP_YMR", as.character(df_year$source_file), useBytes=TRUE),]

## Confirming only original Young Meyer Ranch Files were included.
length(unique(Young_Meyer_Ranch_GP$source_file))==length(all_files_nd[grep("GP_YMR", all_files_nd)]) ## equal at 72

setdiff(unique(Young_Meyer_Ranch_GP$source_file), all_files_nd[grep("GP_YMR", all_files_nd)]) ## 0

sum(table(Young_Meyer_Ranch_GP$source_file))==nrow(Young_Meyer_Ranch_GP) ## equal ~1100000

############## Mountain West Watersheds
####### Dry Creek

Dry_Creek_MW <- df_year[grep("MW_JDR_DRC", as.character(df_year$source_file), useBytes=TRUE),]

## Confirming only original Dry Creek Files were included.
length(unique(Dry_Creek_MW$source_file))==length(all_files_nd[grep("MW_JDR_DRC", all_files_nd)]) ## equal at 75

setdiff(unique(Dry_Creek_MW$source_file), all_files_nd[grep("MW_JDR_DRC", all_files_nd)]) ## 0

sum(table(Dry_Creek_MW$source_file))==nrow(Dry_Creek_MW) ## equal ~1700000


####### Gibson Jack Creek

Gibson_Jack_Creek_MW <- df_year[grep("MW_GBJ", as.character(df_year$source_file), useBytes=TRUE),]

## Confirming only original Gibson Jack Files were included.
length(unique(Gibson_Jack_Creek_MW$source_file))==length(all_files_nd[grep("MW_GBJ", all_files_nd)]) ## equal at 159

setdiff(unique(Gibson_Jack_Creek_MW$source_file), all_files_nd[grep("MW_GBJ", all_files_nd)]) ## 0

sum(table(Gibson_Jack_Creek_MW$source_file))==nrow(Gibson_Jack_Creek_MW) ## equal ~3260000

####### Johnston Draw Creek

Johnston_Draw_Creek_MW <- df_year[grep("MW_JDR_JDR", as.character(df_year$source_file), useBytes=TRUE),]

## Confirming only original Johnston Draw Files were included.
length(unique(Johnston_Draw_Creek_MW$source_file))==length(all_files_nd[grep("MW_JDR_JDR", all_files_nd)]) ## equal at 96

setdiff(unique(Johnston_Draw_Creek_MW$source_file), all_files_nd[grep("MW_JDR_JDR", all_files_nd)]) ## 0

sum(table(Johnston_Draw_Creek_MW$source_file))==nrow(Johnston_Draw_Creek_MW) ## equal ~2200000


############## South East Watersheds
####### Talladega Creek

Talladega_SE <- df_year[grep("SE_TAL_TL", as.character(df_year$source_file), useBytes=TRUE),]

## Confirming only original Talladega Creek Files were included.
length(unique(Talladega_SE$source_file))==length(all_files_nd[grep("SE_TAL_TL", all_files_nd)]) ## equal at 137

setdiff(unique(Talladega_SE$source_file), all_files_nd[grep("SE_TAL_TL", all_files_nd)]) ## 0

sum(table(Talladega_SE$source_file))==nrow(Talladega_SE) ## equal ~2700000


####### Paint Rock Creek

Paint_Rock_Creek_SE <- df_year[grep("SE_PRF", as.character(df_year$source_file), useBytes=TRUE),]

## Confirming only original Gibson Jack Files were included.
length(unique(Paint_Rock_Creek_SE$source_file))==length(all_files_nd[grep("SE_PRF", all_files_nd)]) ## equal at 78

setdiff(unique(Paint_Rock_Creek_SE$source_file), all_files_nd[grep("SE_PRF", all_files_nd)]) ## 0

sum(table(Paint_Rock_Creek_SE$source_file))==nrow(Paint_Rock_Creek_SE) ## equal at 873209

####### Coastal Plain / Shambley Creek

Shambley_Creek_SE <- df_year[grep("SE_WHR", as.character(df_year$source_file), useBytes=TRUE),]

## Confirming only original Johnston Draw Files were included.
length(unique(Shambley_Creek_SE$source_file))==length(all_files_nd[grep("SE_WHR", all_files_nd)]) ## equal at 80

setdiff(unique(Shambley_Creek_SE$source_file), all_files_nd[grep("SE_WHR", all_files_nd)]) ## 0

sum(table(Shambley_Creek_SE$source_file))==nrow(Shambley_Creek_SE) ## equal at 1807794

### Final Row Confirmation:

(nrow(Paint_Rock_Creek_SE) + nrow(Talladega_SE) + nrow(Shambley_Creek_SE) + 
    nrow(Johnston_Draw_Creek_MW)+nrow(Gibson_Jack_Creek_MW)+ nrow(Dry_Creek_MW)+
    nrow(Young_Meyer_Ranch_GP)+nrow(Shane_Creek_Konza_Prarie_GP)+nrow(Kings_Creek_Konza_Prarie_GP)) == nrow(df_year)
rm(df_year)


################################################################################


### Making Each Region

Kings_Creek_Konza_Prarie_GP <- Kings_Creek_Konza_Prarie_GP |> mutate(
  Watershed = "KNZ"
)
Shane_Creek_Konza_Prarie_GP <- Shane_Creek_Konza_Prarie_GP |> mutate(
  Watershed = "SHN"
)
Young_Meyer_Ranch_GP <- Young_Meyer_Ranch_GP |> mutate(
  Watershed = "YMR"
)

GP <- bind_rows(
  Kings_Creek_Konza_Prarie_GP,
  Shane_Creek_Konza_Prarie_GP,
  Young_Meyer_Ranch_GP
)

rm(Kings_Creek_Konza_Prarie_GP); rm(Shane_Creek_Konza_Prarie_GP); rm(Young_Meyer_Ranch_GP)

################################################################################

Dry_Creek_MW <- Dry_Creek_MW |> mutate(
  Watershed="DRC"
)

Gibson_Jack_Creek_MW <- Gibson_Jack_Creek_MW |> mutate(
  Watershed="GBJ"
)

Johnston_Draw_Creek_MW <- Johnston_Draw_Creek_MW |> mutate(
  Watershed="JDR"
)

MW <- bind_rows(
  Dry_Creek_MW,
  Gibson_Jack_Creek_MW,
  Johnston_Draw_Creek_MW
)

rm(Dry_Creek_MW,
   Gibson_Jack_Creek_MW,
   Johnston_Draw_Creek_MW)

#############################################################

Talladega_SE <- Talladega_SE |> mutate(
  Watershed="TAL"
)

Paint_Rock_Creek_SE <- Paint_Rock_Creek_SE |> mutate(
  Watershed="PRF"
)

Shambley_Creek_SE <- Shambley_Creek_SE |> mutate(
  Watershed="WHR"
)

SE <- bind_rows(
  Talladega_SE,
  Paint_Rock_Creek_SE,
  Shambley_Creek_SE
)

rm(Talladega_SE,
   Paint_Rock_Creek_SE,
   Shambley_Creek_SE)

################################################################################

### Begin Quality Control:

#### Using Serial Numbers to isolate problem sensors

Acceptable = GP |> group_by(Watershed,siteId,Year,SN) |> summarise(
  n=n(),
  n_NA = sum(is.na(qual_rating)),
  poor = sum(qual_rating=="poor",na.rm=TRUE),
  prop = poor/(n - n_NA), ## Only counting the proportion based on recorded values, not NAs
  .groups = "drop"
) |> mutate(
  Pass_or_Fail = ifelse(prop > 0.5, "FAIL", "PASS")
) |> filter(Pass_or_Fail == "PASS")

GP_QC <- semi_join(GP, Acceptable,by = c("Watershed", "siteId", "Year", "SN")) ## Keep only rows with the column values found in Acceptable


#############################################################

Acceptable_MW = MW |> group_by(Watershed,siteId,Year,SN) |> summarise(
  n=n(),
  n_NA = sum(is.na(qual_rating)),
  poor = sum(qual_rating=="poor",na.rm=TRUE),
  prop = poor/(n - n_NA), ## Only counting the proportion based on recorded values, not NAs
  .groups = "drop"
) |> mutate(
  Pass_or_Fail = ifelse(prop > 0.5, "FAIL", "PASS")
) |> filter(Pass_or_Fail == "PASS")

MW_QC <- semi_join(MW, Acceptable_MW,by = c("Watershed", "siteId", "Year", "SN")) ## Keep only rows with the column values found in Acceptable

#############################################################

Acceptable_SE = SE |> group_by(Watershed,siteId,Year,SN) |> summarise(
  n=n(),
  n_NA = sum(is.na(qual_rating)),
  poor = sum(qual_rating=="poor",na.rm=TRUE),
  prop = poor/(n - n_NA), ## Only counting the proportion based on recorded values, not NAs
  .groups = "drop"
) |> mutate(
  Pass_or_Fail = ifelse(prop > 0.5, "FAIL", "PASS")
) |> filter(Pass_or_Fail == "PASS")

SE_QC <- semi_join(SE, Acceptable_SE,by = c("Watershed", "siteId", "Year", "SN")) ## Keep only rows with the column values found in Acceptable


list(
  Rows_RM_GP = (nrow(GP)-nrow(GP_QC)),
  Rows_RM_MW = (nrow(MW)-nrow(MW_QC)),
  Rows_RM_SE = (nrow(SE)-nrow(SE_QC)),
  prop_GP = nrow(GP_QC)/nrow(GP),
  prop_MW = nrow(MW_QC)/nrow(MW),
  prop_SE = nrow(SE_QC)/nrow(SE) ### Proportion of data that survived the QC
)

rm(Acceptable,Acceptable_MW,Acceptable_SE)
rm(GP,MW,SE)

### Dropping unneeded columns:

GP_QC <- GP_QC |> select(
  -c(source_file,project,sublocation,SN, condUncal,tempC,rep)
)
MW_QC <- MW_QC |> select(
  -c(source_file,project,sublocation,SN, condUncal,tempC,rep)
)
SE_QC <- SE_QC |> select(
  -c(source_file,project,sublocation,SN, condUncal,tempC,rep)
)

################################################################################

### The Heatmaps:

GP_QC <- GP_QC |> mutate(
  Date = as.Date(datetime)
) |> select(-datetime)

GP_summary = GP_QC |> group_by(Date,siteId,Year,Watershed) |> summarise(
  n=sum(!is.na(wetdry)),
  dry_obs=sum(wetdry==0,na.rm=TRUE),
  proportion = dry_obs/n
) #|> mutate(

GP_year <- GP_summary |>
  group_by(siteId, Year, Watershed) |>
  summarise(
    days = sum(n > 0), ## cant divide by 0
    dry_obs = sum(proportion > 0.5, na.rm = TRUE), ## Deciding if the day was dry using a 0.5 proportion cuttoff
    proportion = dry_obs / days,
    .groups = "drop"
  )

rm(GP_summary)

### Great Plains Maps

if (!dir.exists("Heatmaps")) {
  dir.create("Heatmaps")
}

for (ws in unique(GP_year$Watershed)){
  watershed = GP_year |> filter(Watershed == ws)
  
  plot <- ggplot(watershed,aes(x = factor(Year),y = siteId, fill=proportion)) +
    geom_tile(
      data = expand.grid(
        Year = 2021:2025,
        siteId = unique(watershed$siteId)
      ),
      fill = "grey"
    )+ 
    geom_tile() +
    labs(
      x = "Year",
      y = "Site",
      title = paste("Annual Proportion of Dry Days at", ws),
      subtitle = "Gray values were unobserved"
    ) +  scale_fill_viridis_c(
      option = "plasma",
      limits = c(0, 1),
      name = "Proportion\ndry",
      na.value = "grey"
    )+
    theme_minimal()
  print(plot)
  
  ggsave(
    filename = file.path("Heatmaps", paste0(ws, "_heatmap.png")),
    plot = plot,
    width = 7,
    height = 7,
    dpi = 300
  )
  
}

##### The data coverage heat map loop:
for (dc in unique(GP_year$Watershed)){
  coverage = GP_year |> filter(Watershed == dc)
  
  plot <- ggplot(coverage,aes(x = factor(Year),y = siteId, fill=days)) +
    geom_tile(
      data = expand.grid(
        Year = 2021:2025,
        siteId = unique(coverage$siteId)
      ),
      fill = "grey"
    )+ 
    geom_tile() +
    labs(
      x = "Year",
      y = "Site",
      title = paste("Number of Included Observations at",dc),
      subtitle = "Light Gray values were unobserved"
    ) +  scale_fill_viridis_b(
      option = "cividis",
      name = "Observations\n Per Year",
      limits = c(min(coverage$days), 365),
      na.value = "grey"
    )+
    theme_minimal()
  
  ggsave(
    filename=file.path("Heatmaps", paste0(dc, "_obsheatmap.png")),
    plot=plot,
    width = 7,
    height = 7,
    dpi = 300,
  )
}


### The tables:

quant <- quantile(GP_year$days,na.rm = TRUE) ## Only taking the top 75% of days - Removes faulty readings from sensors only active for limited days

GP_year <- GP_year |> filter(days >= as.numeric(quant[2]))

GP_mean <- GP_year |> group_by(siteId,Watershed) |> 
  summarise(
    Average_Proportion_Dry_Days = weighted.mean(proportion,w=days,na.rm=TRUE), ## Using the weighted averages to account for differing day lengths
    .groups="drop"
  )


GP_mean <- GP_mean[order(GP_mean$Average_Proportion_Dry_Days, decreasing = TRUE),]

GP_mean |>
  head() |>
  knitr::kable(
    digits = 4,
    col.names = c(
      "Site",
      "Watershed",
      "Average Proportion of Dry Days"
    ),
    caption = "Great Plains Sites with Highest Proportion of Dry Days"
  )

GP_mean |> group_by(Watershed) |> summarise(
  Average_Proportion_Dry_Days = mean(Average_Proportion_Dry_Days)
) |> knitr::kable(
  digits = 4,
  col.names = c(
    "Watershed",
    "Average Proportion of Dry Days"
  ),
  caption = "Proportion of Dry Days by Watershed"
)

rm(GP_year)

### Mountain West:

MW_summary = MW_QC |> group_by(Date,siteId,Year,Watershed) |> summarise(
  n=sum(!is.na(wetdry)),
  dry_obs=sum(wetdry==0,na.rm=TRUE),
  proportion = dry_obs/n)

MW_year <- MW_summary |>
  group_by(siteId, Year, Watershed) |>
  summarise(
    days = sum(n > 0), ## cant divide by 0
    dry_obs = sum(proportion > 0.5, na.rm = TRUE), ## Deciding if the day was dry using a 0.5 proportion cuttoff
    proportion = dry_obs / days,
    .groups = "drop"
  )

rm(MW_summary)

for (ws in unique(MW_year$Watershed)){
  watershed = MW_year |> filter(Watershed == ws)
  
  plot <- ggplot(watershed,aes(x = factor(Year),y = siteId, fill=proportion)) +
    geom_tile(
      data = expand.grid(
        Year = 2021:2025,
        siteId = unique(watershed$siteId)
      ),
      fill = "grey"
    )+ 
    geom_tile() +
    labs(
      x = "Year",
      y = "Site",
      title = paste("Annual Proportion of Dry Days at", ws),
      subtitle = "Gray values were unobserved"
    ) +  scale_fill_viridis_c(
      option = "plasma",
      limits = c(0, 1),
      name = "Proportion\ndry",
      na.value = "grey"
    )+
    theme_minimal()
  print(plot)
  
  ggsave(
    filename = file.path("Heatmaps", paste0(ws, "_heatmap.png")),
    plot = plot,
    width = 7,
    height = 7,
    dpi = 300
  )
  
}

##### The data coverage heat map loop:
for (dc in unique(MW_year$Watershed)){
  coverage = MW_year |> filter(Watershed == dc)
  
  plot <- ggplot(coverage,aes(x = factor(Year),y = siteId, fill=days)) +
    geom_tile(
      data = expand.grid(
        Year = 2021:2025,
        siteId = unique(coverage$siteId)
      ),
      fill = "grey"
    )+ 
    geom_tile() +
    labs(
      x = "Year",
      y = "Site",
      title = paste("Number of Included Observations at",dc),
      subtitle = "Light Gray values were unobserved"
    ) +  scale_fill_viridis_b(
      option = "cividis",
      name = "Observations\n Per Year",
      limits = c(min(coverage$days), 365),
      na.value = "grey"
    )+
    theme_minimal()
  
  ggsave(
    filename=file.path("Heatmaps", paste0(dc, "_obsheatmap.png")),
    plot=plot,
    width = 7,
    height = 7,
    dpi = 300,
  )
}

### MW table

quant <- quantile(MW_year$days,na.rm = TRUE) ## Only taking the top 75% of days - Removes faulty readings from sensors only active for limited days

MW_year <- MW_year |> filter(days >= as.numeric(quant[2]))

MW_mean <- MW_year |> group_by(siteId,Watershed) |> 
  summarise(
    Average_Proportion_Dry_Days = weighted.mean(proportion,w=days,na.rm=TRUE), ## Using the weighted averages to account for differing day lengths
    .groups="drop"
  )


MW_mean <- MW_mean[order(MW_mean$Average_Proportion_Dry_Days, decreasing = TRUE),]

MW_mean |>
  head() |>
  knitr::kable(
    digits = 4,
    col.names = c(
      "Site",
      "Watershed",
      "Average Proportion of Dry Days"
    ),
    caption = "Mountain West Sites with Highest Proportion of Dry Days"
  )

MW_mean |> group_by(Watershed) |> summarise(
  Average_Proportion_Dry_Days = mean(Average_Proportion_Dry_Days)
) |> knitr::kable(
  digits = 4,
  col.names = c(
    "Watershed",
    "Average Proportion of Dry Days"
  ),
  caption = "Proportion of Dry Days by Watershed"
)


rm(MW_year)

### Southeast:

SE_summary <- SE_QC |> group_by(Date,siteId,Year, Watershed) |> summarise(
  n = sum(!is.na(wetdry)),
  dry_obs = sum(wetdry==0, na.rm =TRUE),
  proportion = dry_obs / n
)

SE_year <- SE_summary |>
  group_by(siteId, Year, Watershed) |>
  summarise(
    days = sum(n > 0), ## cant divide by 0
    dry_obs = sum(proportion > 0.5, na.rm = TRUE), ## Deciding if the day was dry using a 0.5 proportion cut off
    proportion = dry_obs / days,
    .groups = "drop"
  )

rm(SE_summary)

for (ws in unique(SE_year$Watershed)){
  watershed = SE_year |> filter(Watershed == ws)
  
  plot <- ggplot(watershed,aes(x = factor(Year),y = siteId, fill=proportion)) +
    geom_tile(
      data = expand.grid(
        Year = 2021:2025,
        siteId = unique(watershed$siteId)
      ),
      fill = "grey"
    )+ 
    geom_tile() +
    labs(
      x = "Year",
      y = "Site",
      title = paste("Annual Proportion of Dry Days at", ws),
      subtitle = "Gray values were unobserved"
    ) +  scale_fill_viridis_c(
      option = "plasma",
      limits = c(0, 1),
      name = "Proportion\ndry",
      na.value = "grey"
    )+
    theme_minimal()
  print(plot)
  
  ggsave(
    filename = file.path("Heatmaps", paste0(ws, "_heatmap.png")),
    plot = plot,
    width = 7,
    height = 7,
    dpi = 300
  )
  
}

##### The data coverage heat map loop:
for (dc in unique(SE_year$Watershed)){
  coverage = SE_year |> filter(Watershed == dc)
  
  plot <- ggplot(coverage,aes(x = factor(Year),y = siteId, fill=days)) +
    geom_tile(
      data = expand.grid(
        Year = 2021:2025,
        siteId = unique(coverage$siteId)
      ),
      fill = "grey"
    )+ 
    geom_tile() +
    labs(
      x = "Year",
      y = "Site",
      title = paste("Number of Included Observations at",dc),
      subtitle = "Light Gray values were unobserved"
    ) +  scale_fill_viridis_b(
      option = "cividis",
      name = "Observations\n Per Year",
      limits = c(min(coverage$days), 365),
      na.value = "grey"
    )+
    theme_minimal()
  
  ggsave(
    filename=file.path("Heatmaps", paste0(dc, "_obsheatmap.png")),
    plot=plot,
    width = 7,
    height = 7,
    dpi = 300,
  )
}

quant <- quantile(SE_year$days,na.rm = TRUE) ## Only taking the top 75% of days - Removes faulty readings from sensors only active for limited days

SE_year <- SE_year |> filter(days >= as.numeric(quant[2]))

SE_mean <- SE_year |> group_by(siteId,Watershed) |> 
  summarise(
    Average_Proportion_Dry_Days = weighted.mean(proportion,w=days,na.rm=TRUE), ## Using the weighted averages to account for differing day lengths
    .groups="drop"
  )

### Southeast table:

SE_mean <- SE_mean[order(SE_mean$Average_Proportion_Dry_Days, decreasing = TRUE),]

SE_mean |>
  head() |>
  knitr::kable(
    digits = 4,
    col.names = c(
      "Site",
      "Watershed",
      "Average Proportion of Dry Days"
    ),
    caption = "South East Sites with Highest Proportion of Dry Days"
  )



rm(SE_year)
