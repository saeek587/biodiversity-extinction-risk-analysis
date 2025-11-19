# ============================================
# RANDOM FOREST CLASSIFIER
# Conservation Status Prediction
# Author: Saee Kurhade
# ============================================

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset (update path accordingly)
# dataset = pd.read_csv("factored_table.csv")

# Replace with your data loading code
# Example:
# ds2 = dataset.replace({
#   "LR/lc": "LC",
#   "LR/cd": "LC",
#   "LR/nt": "NT",
#   "CR(PE)": "CR",
#   "CR(PEW)": "CR",
#   "EW": "EX",
#   "NR": "DD"
# })

# Drop columns not needed
# ds2 = ds2.drop(columns=["Scientific name", "Common name"])

# One-hot encode taxonomy and previous status
# X = pd.concat([pd.get_dummies(ds2.iloc[:,0]), pd.get_dummies(ds2.iloc[:,1])], axis=1)
# y = ds2["IUCN Red List 2022"]

# Train/test split
# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=42, stratify=y)

# Model training
# classifier = RandomForestClassifier(n_estimators=100, random_state=42)
# classifier.fit(X_train, y_train)

# Predictions
# y_pred = classifier.predict(X_test)

# Evaluation
# print(confusion_matrix(y_test, y_pred))
# print(classification_report(y_test, y_pred))

# Feature importance
# feature_imp = pd.Series(classifier.feature_importances_, index=X.columns).sort_values(ascending=False)
# sns.barplot(x=feature_imp[:10], y=feature_imp.index[:10])
# plt.title('Top 10 Feature Importances')
# plt.show()
