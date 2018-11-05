library(readtext)
library(dplyr)
library(stringr)
library(SnowballC)
library(tm)
library(wordcloud)

folder_path <- "D:/MS Data Science/CUNY/CUNY/CUNY MSDS/Fall 2018/DATA 607/DATA 607 Week-10/Data 607 Project-4/spamham/All-spam"
file_list <- list.files(path = folder_path)

file_list <- paste(folder_path, "/", file_list, sep = "")

raw_spam <- lapply(file_list, readtext)

raw_spam <- lapply(raw_spam, FUN = paste, collapse = " ")

raw_spam[[1]]

get_email_body <- function(email){
  email_body <- str_split(email,"Subject:.*\n?(.+\n)*\n") %>% lapply('[[',2) %>% unlist()
##  email_body <- str_split(email,"Subject:.*\n?(.+\n)*\n")
  return(email_body)
}

email_body_list <- lapply(raw_spam, get_email_body)


### Collapsing all email bodies
##email_body_text_all <- paste(email_body_list, collapse = " ")

email_body_list[[1]]
file_list[[1]]

email_body_text_corpus <- email_body_list %>% VectorSource() %>% Corpus()

email_body_text_corpus[[2]]

### Corpus cleaning
email_body_text_corpus_cleaned <- email_body_text_corpus %>% tm_map(content_transformer(tolower))
email_body_text_corpus_cleaned <- email_body_text_corpus_cleaned %>% tm_map(removePunctuation)
email_body_text_corpus_cleaned <- email_body_text_corpus_cleaned %>% tm_map(stripWhitespace)
email_body_text_corpus_cleaned <- email_body_text_corpus_cleaned %>% tm_map(removeWords, stopwords("english"))
email_body_text_corpus_cleaned <- email_body_text_corpus_cleaned %>% tm_map(removeNumbers)
email_body_text_corpus_cleaned <- email_body_text_corpus_cleaned %>% tm_map(stemDocument)

email_body_text_corpus_cleaned

inspect(email_body_text_corpus_cleaned[1:3])

email_body_dtm <- DocumentTermMatrix(email_body_text_corpus_cleaned, control = list(weighting = weightTfIdf))
email_body_dtm_matrix <- as.matrix(email_body_dtm)
head(email_body_dtm_matrix)

email_body_dtm

?DocumentTermMatrix
?colSums

email_body_dtm_matrix[1:10, 1:10]
inspect(email_body_dtm[1:10, 1:10])

frequency <- colSums(email_body_dtm_matrix)
frequency <- sort(frequency, decreasing = TRUE)


head(frequency, 20)

str(email_body_dtm_matrix)
str(email_body_dtm)
dim(email_body_dtm_matrix)

class(email_body_dtm_matrix)
class(frequency)
names(frequency)[1:20]

######################## Starting for ham email ##############################

ham_folder_path <- "D:/MS Data Science/CUNY/CUNY/CUNY MSDS/Fall 2018/DATA 607/DATA 607 Week-10/Data 607 Project-4/spamham/All-ham"
ham_file_list <- list.files(path = ham_folder_path)

ham_file_list <- paste(ham_folder_path, "/", ham_file_list, sep = "")

raw_ham <- lapply(ham_file_list, readtext)

raw_ham <- lapply(raw_ham, FUN = paste, collapse = " ")

raw_ham[[1]]

get_email_body <- function(email){
  email_body <- str_split(email,"From:.*\n?(.+\n)*\n") %>% lapply('[[',2) %>% unlist()
  ##  email_body <- str_split(email,"Subject:.*\n?(.+\n)*\n")
  return(email_body)
}

ham_email_body_list <- lapply(raw_ham, get_email_body)

raw_ham[[1]] %>% str_extract("mv ")
ham_email_body_list[[2]]

check_raw_ham <- function(email){
  return(str_extract(email, "Received:.*\n?(.+\n)*\n"))
}

which(is.na(lapply(raw_ham, check_raw_ham)))

which(!is.na(lapply(raw_ham, check_raw_ham)))
raw_ham[[318]]
ham_file_list[[2]]


### Collapsing all email bodies
ham_email_body_text_all <- paste(ham_email_body_list, collapse = " ")

ham_email_body_text_corpus <- ham_email_body_text_all %>% VectorSource() %>% Corpus()


### Corpus cleaning
ham_email_body_text_corpus_cleaned <- ham_email_body_text_corpus %>% tm_map(content_transformer(tolower))
ham_email_body_text_corpus_cleaned <- ham_email_body_text_corpus_cleaned %>% tm_map(removePunctuation)
ham_email_body_text_corpus_cleaned <- ham_email_body_text_corpus_cleaned %>% tm_map(stripWhitespace)
ham_email_body_text_corpus_cleaned <- ham_email_body_text_corpus_cleaned %>% tm_map(removeWords, stopwords("english"))
ham_email_body_text_corpus_cleaned <- ham_email_body_text_corpus_cleaned %>% tm_map(removeNumbers)
ham_email_body_text_corpus_cleaned <- ham_email_body_text_corpus_cleaned %>% tm_map(stemDocument)

email_body_dtm <- DocumentTermMatrix(email_body_text_corpus_cleaned)
email_body_dtm_matrix <- as.matrix(email_body_dtm)
head(email_body_dtm_matrix)

frequency <- colSums(email_body_dtm_matrix)
frequency <- sort(frequency, decreasing = TRUE)


head(frequency, 20)