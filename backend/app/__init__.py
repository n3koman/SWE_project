from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from config import Config
from app.routes.auth_routes import auth_bp

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)
    Migrate(app, db)

    app.register_blueprint(auth_bp)

    # Import models to ensure they're registered
    from app import models

    return app
