# Loading packages
library(httr)
library(jsonlite)
library("writexl")


#iban_list <- c("DE02120300000000202051", "DE02500105170137075030")

# Read in ibans
df_ibans <- read.table("C:/R/web_api_usage_ibans/ibans.txt")

# Create list of ibans to loop through
iban_list <- df_ibans$V1


# List to store results from API calls
combined_data <- list()


for (iban in iban_list){
    # Initializing API Call
    call <- paste0("https://openiban.com/validate/", iban,"?getBIC=true&validateBankCode=true")
    
    # Waiting time to not overload API
    Sys.sleep(2)
    
    # Getting details from API
    get_details <- GET(url = call)
    
    # Getting status of HTTP Call
    status_code(get_details)
    
    # Content in the API
    str(content(get_details))
    
    # Converting content to text
    get_text <- content(get_details,"text", encoding = "UTF-8")
    get_text
    
    # Parsing data in JSON
    get_json <- fromJSON(get_text, flatten = TRUE)
    get_json
    
    # Relevant information found in
    get_json$iban
    get_json["bankData"]$bankData$bic
    
    # Combine relevant data
    collected_data <- c(get_json$iban, get_json["bankData"]$bankData$bic)
    
    # Append newly requested data to combined data
    combined_data <- rbind(combined_data, collected_data)
    combined_data
}

data <- as.data.frame(combined_data)

typeof(data)
typeof(data$V1)
typeof(data$V2)


# the dataframe data contains lists as its variables
# to export data correctly, we need to change the variables to vectors
data$V1 <- as.character(data$V1)
data$V2 <- as.character(data$V2)


typeof(get_json)

write_xlsx(data, "C:\\R\\web_api_usage_ibans\\result.xlsx")
write.csv(data, file = "C:\\R\\web_api_usage_ibans\\result.csv", row.names = FALSE)

