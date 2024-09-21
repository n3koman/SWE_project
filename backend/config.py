class Config:
    # Directly set the PostgreSQL connection string
    SQLALCHEMY_DATABASE_URI = 'postgresql://swefarmers_owner:xIMKRWyh0c4w@ep-aged-field-a2hqqwv8.eu-central-1.aws.neon.tech/swefarmers?sslmode=require'
    SQLALCHEMY_TRACK_MODIFICATIONS = False  # Disabling event notifications
