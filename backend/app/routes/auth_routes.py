from flask import Blueprint, request, jsonify
from app import db
from app.models import User
from werkzeug.security import generate_password_hash

auth_bp = Blueprint('auth_bp', __name__)

@auth_bp.route('/register', methods=['POST'])
def register():
    if request.method == 'GET':
        return jsonify({"message": "Use POST method to register."})

    data = request.get_json()

    if not data or not data.get('name') or not data.get('email') or not data.get('password'):
        return jsonify({"error": "Missing data"}), 400

    name = data['name']
    email = data['email']
    password = data['password']

    # Hash the password for security
    hashed_password = generate_password_hash(password)

    # Check if the user already exists
    existing_user = User.query.filter_by(email=email).first()
    if existing_user:
        return jsonify({"error": "User already exists"}), 409

    # Create a new user instance
    new_user = User(name=name, email=email, password=hashed_password, role='farmer')

    # Add the new user to the database
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User created successfully"}), 201
