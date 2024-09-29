from flask import Blueprint, request, jsonify
from app import db
from app.models import User

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()  # This will get the JSON data from the request
    
    if not data:
        return jsonify({"error": "No input data provided"}), 400

    name = data.get('name')
    email = data.get('email')
    password = data.get('password')
    role = 'buyer'  # Default role

    if not name or not email or not password:
        return jsonify({"error": "Missing fields"}), 400
    
    # Create a new user and save to the database
    new_user = User(name=name, email=email, password=password, role=role)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({"message": "User registered successfully"}), 201
