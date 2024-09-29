from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_restx import Api, Resource, fields  # Import Flask-RESTX components
from config import Config

app = Flask(__name__)
app.config.from_object(Config)

db = SQLAlchemy(app)
migrate = Migrate(app, db)

api = Api(app, version='1.0', title='My API',
          description='A simple API with Swagger UI documentation.')

# Example of defining a model for Swagger docs
user_model = api.model('User', {
    'id': fields.Integer(readOnly=True, description='The unique identifier of a user'),
    'name': fields.String(required=True, description='The name of the user'),
    'email': fields.String(required=True, description='The email of the user'),
})

@api.route('/users')
class UserList(Resource):
    @api.doc('list_users')
    def get(self):
        """List all users"""
        return [{'id': 1, 'name': 'John Doe', 'email': 'john@example.com'}]

    @api.doc('create_user')
    @api.expect(user_model)
    def post(self):
        """Create a new user"""
        return {'result': 'User created'}, 201

@api.route('/users/<int:id>')
class User(Resource):
    @api.doc('get_user')
    def get(self, id):
        """Fetch a user given its identifier"""
        return {'id': id, 'name': 'John Doe', 'email': 'john@example.com'}

@app.route('/')
def test_db():
    return "Welcome to the API"

if __name__ == '__main__':
    app.run(debug=True)
