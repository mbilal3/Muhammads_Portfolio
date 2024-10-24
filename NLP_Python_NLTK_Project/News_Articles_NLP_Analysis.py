# import needed libraries
import os  # needed for directory access
import nltk
nltk.download('punkt')
from nltk.corpus import stopwords
nltk.download('stopwords')
from nltk.tokenize import RegexpTokenizer

# get and set your working directory
os.getcwd()
os.chdir('/Users/nimbi/Desktop/Bilal Spring 22/AIT 580/Assignment 9')
os.getcwd()

# open, read, and display the input file for the Fox News Article
textfile_foxnews = open('Brexit_foxnews.txt', mode='r')
allwords_foxnews = textfile_foxnews.read()
print(allwords_foxnews)
len(allwords_foxnews)

# extract the words, convert all to lower case
tokenizer = RegexpTokenizer(r'\w+')
tokens_foxnews = tokenizer.tokenize(allwords_foxnews.lower())
print(tokens_foxnews)
len(tokens_foxnews)

# recreate token list without stopwords for the Fox News article

tokens_foxnews = [token for token in tokens_foxnews if token not in stopwords.words('english')]
print(tokens_foxnews)
len(tokens_foxnews)
# display and graph the word frequncies, plus a few specific words for the Fox News article
freq_dist = nltk.FreqDist(tokens_foxnews)
freq_dist
freq_dist['Brexit']
freq_dist['Ukraine']

print(freq_dist)
print(freq_dist.most_common(25))
freq_dist.plot(25)

# open, read, and display the input file for The Independent News Article
textfile_theindependent = open('Brexit_theindependent.txt', mode='r',encoding='utf-8')
allwords_theindependent = textfile_theindependent.read()
print(allwords_theindependent)

# extract the words, convert all to lower case for The Independent News Article
tokenizer = RegexpTokenizer(r'\w+')
tokens_theindependent = tokenizer.tokenize(allwords_theindependent.lower())
print(tokens_theindependent)
len(tokens_theindependent)

# recreate token list without stopwords for The Independent News Article
tokens_theindependent = [token for token in tokens_theindependent if token not in stopwords.words('english')]
print(tokens_theindependent)
len(tokens_theindependent)

# display and graph the word frequncies, plus a few specific words  for The Independent News Article
freq_dist = nltk.FreqDist(tokens_theindependent)
freq_dist
freq_dist['Brexit']
freq_dist['Ukraine']

print(freq_dist)
print(freq_dist.most_common(25))
freq_dist.plot(25)

