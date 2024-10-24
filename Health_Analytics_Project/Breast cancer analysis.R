install.packages("rlang")
library(ggplot2)
library(tidyverse)
library(dplyr)
library(corrplot)
library(GGally)
library(magrittr)
library(parsnip)
library(vip)
library(discrim)
library(klaR)
library(rpart.plot)
library(tidymodels)
library(yardstick)
library(knitr)


# setting working directory
setwd('/Users/nimbi/Desktop/HAP 780/Final Project/Breast cancer Prediction')


# Creating a data frame from the csv file
df <- read.csv('breast-cancer-wisconsin.csv')

# Displaying the data
df

# subsetting the data to remove column X with all NA values
# df1 = subset(df, select = -c(X) )
df1 <- df

# checking for any missing values 
sum(is.na(df1))

# Checking for the varaible importance
set.seed(100)
# load the library
library(mlbench)
library(caret)
# load the dataset
data(df1)
str(df1)

# convert the character column to a factor column
df3 <- as.data.frame(unclass(df1),                     # Convert all columns to factor
                       stringsAsFactors = TRUE)
str(df3)

# Binarize the Diagnosis column and convert it into a numeric so it can be used for correlation analysis
df1$diagnosis[df1$diagnosis == "M"] <- 1
df1$diagnosis[df1$diagnosis == "B"] <- 0
t <- transform(df1, diagnosis = as.numeric(diagnosis))

# Importance variable plot
# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
model <- train(diagnosis~., data=df3, method="lvq", preProcess="scale", trControl=control)
# estimate variable importance
importance <- varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
plot(importance)

#testing out the correlation

cor(t$diagnosis,t$radius_mean)


#Generate correlation values for the response variable with each of the other attributes present in the data 
cor1 <- cor(as.matrix(t[,2]),as.matrix(t[,-2]))

# Convert the columns into the rows
cor2 <-as.data.frame(t(cor1))
cor2

# Change the name of the second column
colnames(cor2)<- c("Correlation")

# Covert the row names into a column of its own and name it Attribute
library(tibble)
cor3 <- tibble::rownames_to_column(cor2, "Attribute")

#Plot the correlations of the response variable with each of the predictor variable
p<-ggplot(data=cor3, aes(x=reorder(Attribute,Correlation), y=Correlation)) + geom_bar(stat="identity",fill="blue")
p

# Horizontal bar plot
p + coord_flip()

# Checking for the statistically significant variables
model1 <- glm(diagnosis ~radius_mean, data=t,family="binomial")
summary(model1)

model2 <- glm(diagnosis ~texture_mean, data=t,family="binomial")
summary(model2)

model3 <- glm(diagnosis ~id, data=t,family="binomial")
summary(model3)


model4 <- glm(diagnosis ~perimeter_mean, data=t,family="binomial")
summary(model4)

model5 <- glm(diagnosis ~area_mean, data=t,family="binomial")
summary(model5)

model6 <- glm(diagnosis ~smoothness_mean, data=t,family="binomial")
summary(model6)

model7 <- glm(diagnosis ~compactness_mean, data=t,family="binomial")
summary(model7)

model8 <- glm(diagnosis ~concavity_mean, data=t,family="binomial")
summary(model8)

model9 <- glm(diagnosis ~concave.points_mean, data=t,family="binomial")
summary(model9)

model10 <- glm(diagnosis ~symmetry_mean, data=t,family="binomial")
summary(model10)

model11 <- glm(diagnosis ~fractal_dimension_mean, data=t,family="binomial")
summary(model11)

model12 <- glm(diagnosis ~radius_se, data=t,family="binomial")
summary(model12)

model13 <- glm(diagnosis ~texture_se, data=t,family="binomial")
summary(model13)

model14 <- glm(diagnosis ~perimeter_se, data=t,family="binomial")
summary(model14)

model15 <- glm(diagnosis ~area_se, data=t,family="binomial")
summary(model15)

model16 <- glm(diagnosis ~smoothness_se , data=t,family="binomial")
summary(model16)

model17 <- glm(diagnosis ~compactness_se, data=t,family="binomial")
summary(model17)

model18 <- glm(diagnosis ~concavity_se, data=t,family="binomial")
summary(model18)

model19 <- glm(diagnosis ~concave.points_se, data=t,family="binomial")
summary(model19)

model20 <- glm(diagnosis ~symmetry_se, data=t,family="binomial")
summary(model20)

model21 <- glm(diagnosis ~fractal_dimension_se, data=t,family="binomial")
summary(model21)

model22 <- glm(diagnosis ~radius_worst, data=t,family="binomial")
summary(model22)

model23 <- glm(diagnosis ~texture_worst, data=t,family="binomial")
summary(model23)

model24 <- glm(diagnosis ~perimeter_worst, data=t,family="binomial")
summary(model24)

model25 <- glm(diagnosis ~area_worst, data=t,family="binomial")
summary(model25)

model26 <- glm(diagnosis ~smoothness_worst, data=t,family="binomial")
summary(model26)

model27 <- glm(diagnosis ~compactness_worst, data=t,family="binomial")
summary(model27)

model28 <- glm(diagnosis ~concavity_worst, data=t,family="binomial")
summary(model28)

model29 <- glm(diagnosis ~concave.points_worst, data=t,family="binomial")
summary(model29)

model30 <- glm(diagnosis ~symmetry_worst, data=t,family="binomial")
summary(model30)

model31 <- glm(diagnosis ~fractal_dimension_worst, data=t,family="binomial")

summary(model31)


# Removing statistically insignificant variables from the data set
#data_frame = subset(t, select = -c(id,concave.points_mean,fractal_dimension_mean,texture_se,smoothness_se,symmetry_se,fractal_dimension_se) )

data_frame1 = subset(df3, select = -c(id,concave.points_mean,fractal_dimension_mean,texture_se,smoothness_se,symmetry_se,fractal_dimension_se) )

#a1 <- as.factor(df$diagnosis)
# Dividing the data into train and test sets
#make this code reproducible
#set.seed(20)
#use 80% of dataset as training set and 20% as test set
#sample <- sample(c(TRUE, FALSE), nrow(data_frame), replace=TRUE, prob=c(0.8,0.2))
#train  <- data_frame[sample, ]
#test   <- data_frame[!sample, ]
# Implementing logictic regression model on all the statistically significant variables
#model_logistic <- glm(diagnosis ~., data=train,family="binomial")

#summary(model_logistic)

#p <- predict(model_logistic, test)
#head(p)
#view(p)

#model_logistic.prob = predict(model_logistic, test, type="response")
#model_logistic.pred = rep("0", dim(train)[1])
#model_logistic.pred[model_logistic.prob > 0.5] = "1"
#table(model_logistic.pred, train$diagnosis)

#set.seed(20)

#mean(model_logistic.pred == train$diagnosis)

#mean(model_logistic.pred == test$diagnosis)

#mean(predicted.classes == test$diagnosis)
# Trying to test the model
#pred <- predict(model_logistic,newdata = test)
#accuracy <- table(pred, test[,'diagnosis'])
#sum(diag(accuracy))/sum(accuracy)

#aic(model_logistic)
#summary(model_logistic)

#model40 <- glm(diagnosis ~ radius_mean, data=train,family="binomial")

# Logistic classification Model

# Reordering the factors

data_frame1$diagnosis <- factor(gsub("\\s*", "", data_frame1$diagnosis), levels=c("M", "B"))

levels(data_frame1$diagnosis)



set.seed(500)

data_split <- initial_split(data_frame1, prop = 0.70, 
                              strata = diagnosis)

data_split

data_training <- data_split %>% training()
data_training

data_testing <- data_split %>% testing()
data_testing

data_recipe <- recipe(diagnosis ~ .,
                        data = data_training)
summary(data_recipe)

data_transformations <- recipe(diagnosis ~ ., data = data_training)  %>% 
  # Transformation steps
  step_corr(all_numeric(), -all_outcomes(), threshold = 0.70) %>%
  step_YeoJohnson(all_numeric(), -all_outcomes()) %>%
  step_normalize(all_numeric(), -all_outcomes()) %>% 
  step_dummy(all_nominal(), -all_outcomes()) %>% 
  # Train transformations on employee_training
  prep(training = data_training)

# Apply to the test data
data_transformations %>% 
  bake(new_data = data_testing)

logistic_model <- logistic_reg() %>% 
  set_engine('glm') %>% 
  set_mode('classification')
data_wf <- workflow() %>% 
  add_model(logistic_model) %>% 
  add_recipe(data_recipe)

data_logistic_fit <- data_wf %>% 
  fit(data = data_training)


data_trained_model <- data_logistic_fit %>% 
  extract_fit_parsnip()


vip(data_trained_model)

# Evaluate performance
predictions_categories <- predict(data_logistic_fit, new_data = data_testing)

predictions_categories

predictions_probabilities <- predict(data_logistic_fit, new_data = data_testing, type = 'prob')

predictions_probabilities

# Combine

test_results <- data_testing %>% dplyr::select(diagnosis) %>% 
bind_cols(predictions_categories) %>% bind_cols(predictions_probabilities)

test_results

conf_mat(test_results, truth = diagnosis, estimate = .pred_class)

f_meas(test_results, truth = diagnosis, estimate = .pred_class)

sens(test_results, truth = diagnosis, estimate = .pred_class)

spec(test_results, truth = diagnosis, estimate = .pred_class)

roc_auc(test_results, truth = diagnosis, estimate = .pred_class)

accuracy(test_results, truth = diagnosis, estimate = .pred_class)

roc_curve(test_results, truth = diagnosis, estimate = .pred_M)


# ----------------


my_metrics <- metric_set(sens,spec,f_meas,accuracy)

my_metrics

my_metrics(test_results, truth = diagnosis, estimate = .pred_class)


last_fit_model <- data_wf %>% 
  last_fit(split = data_split,
           metrics = my_metrics)
last_fit_model %>% 
  collect_metrics()

last_fit_results <- last_fit_model %>% 
  collect_predictions()

last_fit_results

last_fit_results %>% roc_curve(truth = diagnosis, estimate = .pred_M) %>%autoplot()
conf_mat(last_fit_results, truth = diagnosis , estimate = .pred_class)

#-----------------------------------------------------
# Implementation of the random forest model
set.seed(500)

rf_model <- rand_forest(mtry = tune(),
                        trees = tune(),
                        min_n = tune()) %>% 
  set_engine('ranger', importance = "impurity") %>% 
  set_mode('classification')


rf_workflow <- workflow() %>% 
  add_model(rf_model) %>% 
  add_recipe(data_transformations)

data_folds <- vfold_cv(data_training, v = 5)


rf_grid <- grid_random(mtry() %>% range_set(c(3, 7)),
                       trees(),
                       min_n(),
                       size = 7)

rf_grid



# Tuning random forest workflow
rf_tuning <- rf_workflow %>% 
  tune_grid(resamples = data_folds,
            grid = rf_grid)

rf_tuning %>% show_best('roc_auc')

best_rf <- rf_tuning %>% 
  select_best(metric = 'roc_auc')

# View the best parameters
best_rf

final_rf_workflow <- rf_workflow %>% 
  finalize_workflow(best_rf)

rf_wf_fit <- final_rf_workflow %>% 
  fit(data = data_training)

rf_fit <- rf_wf_fit %>% 
  extract_fit_parsnip()

vip(rf_fit)

rf_last_fit <- final_rf_workflow %>% 
  last_fit(data_split)



rf_last_fit %>% collect_metrics()

rf_last_fit %>% collect_predictions() %>% 
  roc_curve(truth  = diagnosis, estimate = .pred_M) %>% 
  autoplot()

rf_predictions <- rf_last_fit %>% collect_predictions()

conf_mat(rf_predictions, truth = diagnosis, estimate = .pred_class)

f_meas(rf_predictions, truth = diagnosis, estimate = .pred_class)

accuracy(rf_predictions, truth = diagnosis, estimate = .pred_class)

conf_mat(rf_predictions, truth = diagnosis, estimate = .pred_class)

sens(rf_predictions, truth = diagnosis, estimate = .pred_class)

spec(rf_predictions, truth = diagnosis, estimate = .pred_class)

roc_auc(rf_predictions, truth = diagnosis, estimate = .pred_class)


#----------------------------------------------------------
# KNN Model Implementation
data_transformations %>% 
  bake(new_data = credit_testing)


Knn_model <- nearest_neighbor() %>% 
  set_engine('kknn') %>% 
  set_mode('classification')

Knn_model


knn_wf <- workflow() %>% 
add_model(Knn_model) %>% add_recipe(data_transformations)

data_knn_fit <- knn_wf %>% 
  fit(data = data_training)

knn_trained_model <- data_knn_fit %>% 
  extract_fit_parsnip()

my_metrics <- metric_set(accuracy,sens,spec,f_meas,roc_auc)

knn_fit_model <- knn_wf %>% 
  last_fit(split = data_split,
           metrics = my_metrics)
knn_fit_model %>% 
  collect_metrics()

knn_fit_results <- knn_fit_model %>% 
  collect_predictions()

knn_fit_results

knn_fit_results %>% roc_curve(truth = diagnosis, estimate = .pred_M) %>%autoplot()
conf_mat(knn_fit_results, truth = diagnosis , estimate = .pred_class)




