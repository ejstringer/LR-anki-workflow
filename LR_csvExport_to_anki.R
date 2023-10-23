library(tidyverse)

# export LR ---------------------------------------------------------------

# export phrases from LR as csv with media and human translations

#https://www.languagereactor.com/saved-items

# unzip and move folder to this directory

# import code -------------------------------------------------------------

import_code <- 'LR_Oct2023_'


# directory ---------------------------------------------------------------
folders <- dir()[!dir() %in% dir(pattern = '\\.')]
folder <- folders[!folders %in% c('_imports', '_audio')]

# media names -------------------------------------------------------------

# change media names 
mediaDir <- paste0('./', folder, '/media/')
media <- list.files(mediaDir)

file.rename(from = paste0(mediaDir, media),
            to = paste0(mediaDir, import_code, media))

# load vocab --------------------------------------------------------------

vocab <- read.csv(paste0(folder, '/items.csv'), 
                  header = F, sep = '\t')
names(vocab) <- letters[1:24]
names(vocab)

# card format -------------------------------------------------------------

vocab_import <- vocab %>% select(c, d, x, v, w, j, r, q) %>% 
  rename(front = c, back = d, audio = x, picture = v,
         picture2 = w, usage = j, section = r, tag = q) %>% 
  mutate(usage = paste(usage, tag),
         tag = substr(tag, 1 , regexpr(" E", tag)-1),
         tag = gsub(' ', "_", tag),
         audio = paste0('[sound:',import_code, audio, ']'),
         picture = paste0('<img src="', import_code, picture, '">'),
         picture2 = paste0('<img src="', import_code, picture2, '">'))

vocab_import[,c('back', 'audio', 'tag')]
names(vocab_import)

# save --------------------------------------------------------------------

my_importfile <- paste0('./', import_code, 'anki_card_import.csv')
write.csv(vocab_import, my_importfile, row.names = F)

# delete first row in saved csv file and move to import folder

# import to anki ----------------------------------------------------------

# step 1 go to: C:\Users\ejstr\AppData\Roaming\Anki2\User 1\collection.media

# step 2: copy media into folder

# step 3: open anki and import anki_card_import.csv

# step 4: choose em_type card

# step 5: choose Em's Kdramas deck

# step 6: choose comma 

# step 7: add tag to tag

# step 8: ...and import
                               #!! SUCCESS !!#



# tidy directory ----------------------------------------------------------
media_mp3 <- list.files(mediaDir)[grep('mp3', list.files(mediaDir))]
file.copy(from = paste0(mediaDir, media_mp3),
          to = paste0("./_audio/", media_mp3))

unlink(folder,recursive = TRUE)

