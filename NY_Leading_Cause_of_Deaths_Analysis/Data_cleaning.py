import pandas as pd
import numpy as np


#Loading the raw data from the CSV file
df_raw = pd.read_csv(r'C:\Users\nimbi\Desktop\Bilal Spring 22\AIT 580\Final Project\NY_leading_cause_of_deaths.csv')
df_raw


#Removing blank spaces and replacing them with NAN values
df_raw.replace(' ', np.nan, inplace=True)

#Removing rows containing data values with only dots and replacing them with NAN values
df_raw.replace('.', np.nan, inplace=True)

#Removing all of the rows containing NAN values
df_new = df_raw.dropna()
df_new

#Removing all the rows that contain "Not Stated/Unknown" string in the Racial_Ethnicity column of the dataframe
df_modified = df_new[df_new["Racial_Ethnicity"].str.contains("Not Stated/Unknown") == False]
df_modified

#Saving the cleaned data as a CSV file
df_modified.to_csv(r'C:\Users\nimbi\Desktop\Bilal Spring 22\AIT 580\Final Project\Data Cleaned.csv')
