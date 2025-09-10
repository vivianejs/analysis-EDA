import pandas as pd
from joblib import load
from .preprocess import load_data, clean_data, encode_categorical

def predict_genre(csv_path='data/movies.csv', model_path='models/genre_model.joblib', output='pred_genre.csv'):
    df = load_data(csv_path)
    df_clean = clean_data(df)
    df_encoded = encode_categorical(df_clean, ['genre'])
    
    model = load(model_path)
    predictions = model.predict(df_encoded.drop(columns=['genre']))
    
    df['predicted_genre'] = predictions
    df.to_csv(output, index=False)
    print(f"Predições salvas em {output}")
