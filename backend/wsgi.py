from flask import Flask, jsonify, url_for
from app import create_app, db
from flask_migrate import Migrate
from sqlalchemy import text

app = create_app()  # Use the create_app function to create the Flask app
migrate = Migrate(app, db)  # Initialize Flask-Migrate

@app.route('/')
def test_db():
    try:
        with db.engine.connect() as connection:
            result = connection.execute(text("SELECT 1"))
            return f"Database Connected: {result.fetchone()[0]}"
    except Exception as e:
        return f"Error: {e}"

@app.route('/docs')
def list_routes():
    routes = []
    for rule in app.url_map.iter_rules():
        if rule.endpoint != 'static':
            routes.append({
                "endpoint": rule.endpoint,
                "methods": list(rule.methods),
                "url": url_for(rule.endpoint, **(rule.defaults or {}))
            })
    
    return jsonify(routes), 200

if __name__ == '__main__':
    app.run(debug=True)
