# Load required libraries
install.packages("dplyr")
library("dplyr")

# Define a list of stock symbols
stock_symbols = c("IBM","MSFT","GOOG","AAPL","AMZN","FB")

# Create an empty list to store dataframes
dataframes_list = list()

# Loop through each stock symbol and load data into a dataframe
for (symbol in stock_symbols) {
  file_name = paste0(symbol, "_data.csv")
  df = read.csv(file_name)
  dataframes_list[[symbol]] = df
}

# this renames columns to match
for (symbol in stock_symbols) {
  df = dataframes_list[[symbol]]
  colnames(df) = c("Date", "Open", "High", "Low", "Close", "Adj_Close", "Volume")
  dataframes_list[[symbol]] = df
}


dataframes_list

# this will create an empty list to store dividend dataframes
dividend_list = list()

# this will loop through each stock dataframe to compute dividends for finishing the list previouly empty
for (symbol in stock_symbols) {
  df = dataframes_list[[symbol]]
  df$Ratio_Close = c(NA, df$Close[-nrow(df)] / df$Close[-1])
  df$Ratio_Adj_Close = c(NA, df$Adj_Close[-nrow(df)] / df$Adj_Close[-1])
  df$Dividend = df$Close * (df$Ratio_Close - df$Ratio_Adj_Close)
  dividend_df = df[!is.na(df$Dividend), c("Date", "Dividend")]
  dividend_list[[symbol]] = dividend_df
}

df

# this list is of date and dividend amount for each day and stock
# typing the name within [] will show only day and dividend for the wanted stock
dividend_list[["IBM"]]

options(scipen = 10)
