class UserController < ApplicationController

  def register_user
    user_name = params['user_name']
    password = params['password']
    first_name = params['first_name']
    last_name = params['last_name']
    billing_address = params['billing_address']
    delivery_address = params['delivery_address']

    user = User.register_user(user_name, password, first_name, last_name, billing_address, delivery_address)

    render json: user
  end

  def login_user
    user_name = params['user_name']
    password = params['password']

    user = User.login_user(user_name, password)
    render json: user
  end

  def update_user
    id = params['id']
    user_name = params['user_name']
    password = params['password']
    first_name = params['first_name']
    last_name = params['last_name']
    billing_address = params['billing_address']
    delivery_address = params['delivery_address']


  end
end
