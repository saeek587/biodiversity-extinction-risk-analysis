# ============================================
# RANDOM FOREST CLASSIFIER
# Conservation Status Prediction
# Author: Saee Kurhade
# ============================================

import pandas as pd
import numpy as np



import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset (update path accordingly)
dataset = pd.read_excel("C:\Users\SAEE KURHADE\Desktop\Stats Project\Markov_Random_Forest.xlsx")

# Replace with your data loading code
# Example:
ds2 = dataset.replace([ "LR/lc","LC","LR/cd","LR/nt","CR(PE)","CR(PEW)","EW","NR","DD"],['LC','LC','NT','CR','CR','EX','LC','LC'])

# Drop columns not needed
ds2 = ds2.drop(columns=["Scientific name", "Common name"])
#using ordinal encoder on response vector
from sklearn.preprocessing import OrdinalEncoder
enc = OrdinalEncoder(categories= [[ ’LC’ , ’NT’ , ’VU’ , ’EN’ , ’CR’ , ’EX’]])
print(ds2 [ 'IUCN Red List (2021) ']. value counts ())
print(ds2 [ 'IUCN Red List (2022) ']. value counts ())
f1 = enc.fit_transform(ds2. iloc [: ,[1]])
f1 = f1.reshape(2024,)

# One-hot encode taxonomy and previous status
ds4 = pd.get_dummies(ds3 [0])
ds5 = pd.get_dummies(ds3 [1])
ds3 [ds4.columns]=ds4
ds4 [ds5.columns]=ds5
ds4 [res.columns] = res
ds3.drop(0,axis=1,inplace=True)
 
y = ds4['IUCN Red List (2022)']
ds4.drop('IUCN Red List (2022)' , axis=1,inplace=True)
X = ds4

# Train/test split
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=0)

# Model training
from sklearn.ensemble import RandomForestClassifier
classifier = RandomForestClassifier(n_estimators=100, criterion= 'gini',random_state=0)
classifier.fit(X_train, y_train)

# Predictions
y_pred = classifier.predict(X_test)
pred = classifier.predict(X_train)


# Evaluation

from sklearn.metrics import classification_report, confusion_matrix
# print(confusion_matrix(y_test, y_pred))
# print(classification_report(y_test, y_pred))

