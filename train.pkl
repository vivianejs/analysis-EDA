import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor
from joblib import dump
from .preprocess import load_data, clean_data, encode_categorical

def train_genre_model(csv_path='data/movies.csv', model_path='models/genre_model.joblib'):
    df = load_data(csv_path)
    df = clean_data(df)
    df = encode_categorical(df, ['genre'])

    X = df.drop(columns=['genre'])
    y = df['genre']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)
    dump(model, model_path)
    print(f"Modelo de gênero salvo em {model_path}")

def train_rating_model(csv_path='data/movies.csv', model_path='models/rating_model.joblib'):
    df = load_data(csv_path)
    df = clean_data(df)

    X = df.drop(columns=['rating'])
    y = df['rating']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    model = RandomForestRegressor(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)
    dump(model, model_path)
    print(f"Modelo de rating salvo em {model_path}")
