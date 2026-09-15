#### Put directly downloaded zipped files from Hydroshare into working directory

### The (not so simple) simple files: b603 (YMR), c5cd (SHN), ff41 (DRC), 8dab (GBJ), 7ba0 (JDR)
nm_files = list.files(pattern = "^(b603|c5cd|ff41|8dab|7ba0)", full.names = TRUE)
for (i in unique(nm_files)){
  unzip(i, exdir = "extracted")
}

ex_files = list.files(path="./extracted", pattern = "\\.zip$", recursive = TRUE, full.names = TRUE)
ex_files = ex_files[grepl("^./extracted/(7ba0|8dab|b603|c5cd|ff41)", ex_files)]
for(j in seq_along(ex_files)){
  
  out = tools::file_path_sans_ext(ex_files[j])
  
  unzip(ex_files[j],
        files = unzip(ex_files[j], list = TRUE)$Name[
          grepl("\\.csv$", unzip(ex_files[j], list = TRUE)$Name, ignore.case = TRUE)
        ],
        exdir = out)
}
#######################################################################################
### The messy files: Doing individually

PRF <- unzip("d57338ebfb0240f58e8de37ddacf9426.zip",exdir="extracted")
WHR <- unzip("dc623510ed1847f8abe1275904472c44.zip",exdir="extracted")
TAL <- unzip("ff306bec9fb24e52aa809dbb4d074731.zip",exdir="extracted")

## Renamed for readability below
file.rename(
  from = "./extracted/d57338ebfb0240f58e8de37ddacf9426",
  to   = "./extracted/PRF_extracted"
)
file.rename(
  from = "./extracted/dc623510ed1847f8abe1275904472c44",
  to   = "./extracted/WHR_extracted"
)
file.rename(
  from = "./extracted/ff306bec9fb24e52aa809dbb4d074731",
  to   = "./extracted/TAL_extracted"
)
### Moving out of nested files:
# PRF
PRF_CSVs = list.files(path="./extracted/PRF_extracted/data/contents",pattern=".*csv",full.names = TRUE)
dir.create("./extracted/PRF_CSVs")
file.rename(from = PRF_CSVs,to = file.path("./extracted/PRF_CSVs", basename(PRF_CSVs)))

# WHR
WHR_CSVs = list.files(path="./extracted/WHR_extracted/data/contents",pattern=".*csv",full.names = TRUE)
dir.create("./extracted/WHR_CSVs")
file.rename(from = WHR_CSVs,to = file.path("./extracted/WHR_CSVs", basename(WHR_CSVs)))

# TAL
TAL_CSVs = list.files(path="./extracted/TAL_extracted/data/contents",pattern=".*csv",full.names = TRUE)
dir.create("./extracted/TAL_CSVs")
file.rename(from = TAL_CSVs,to = file.path("./extracted/TAL_CSVs", basename(TAL_CSVs)))

##############################################################################
### The one file KNZ

KNZ_files = list.files(pattern = "^62e1b275e84e41d48e28b4ca481a1d9c", full.names = TRUE)
for (j in unique(KNZ_files)){
  unzip(j, exdir="./extracted")
}

### One more loop to extract the years which are still compressed

KNZ_years = list.files(path="./extracted/62e1b275e84e41d48e28b4ca481a1d9c/data/contents",pattern="20.*\\.zip$",full.names = TRUE)
for (l in unique(KNZ_years)){
  unzip(l, exdir="./extracted/62e1b275e84e41d48e28b4ca481a1d9c/data/contents")
}
