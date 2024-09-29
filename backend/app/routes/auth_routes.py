from flask import Blueprint, request, jsonify
from app import db
from app.models import User, Farmer, Buyer, Role
from werkzeug.security import generate_password_hash

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()

    name = data['name']
    email = data['email']
    password = generate_password_hash(data['password'])
    role = data['role']

    # Register as a Farmer
    if role == 'farmer':
        farm_name = data.get('farm_name')
        farm_location = data.get('farm_location')
        farm_size = data.get('farm_size')
        crop_types = data.get('crop_types').split(',') if 'crop_types' in data else []

        new_user = Farmer(
            name=name, email=email, password=password, role=Role.FARMER,
            farm_name=farm_name, farm_location=farm_location, 
            farm_size=farm_size, crop_types=crop_types
        )
    
    # Register as a Buyer
    elif role == 'buyer':
        delivery_address = data.get('delivery_address', '')
        new_user = Buyer(name=name, email=email, password=password, role=Role.BUYER, delivery_address=delivery_address)

    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message': 'User registered successfully'}), 201