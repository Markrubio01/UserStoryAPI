class User < ApplicationRecord

  def self.register_user(user_name, password, first_name, last_name, billing_address, delivery_address)
    error_message = ""
    begin
      if !self.find_by("user_name = ?", user_name).blank?
        success = false
        error_message = "Username already exists"
      else
        user = self.create({user_name: user_name, password: password})
        UserContactInfo.create({user_id: user.id, first_name: first_name, last_name: last_name, billing_address: billing_address, delivery_address: delivery_address})
        success = true
      end
    rescue Exception => e
      error_message =  e.message
      success = false
    end

    return {success: success, error_message: error_message}
  end


  def self.login_user(user_name, password)
    error_message = ""
    begin
      user = self.find_by('user_name = ?', user_name)

      if(user['password'] == password)
        success = true
      else
        success = false
        error_message = "Password is incorrect"
      end

    rescue Exception => e
      success = false
      error_message = e.message
    end

    return {success: success, error_message: error_message}
  end

  def self.update_user(id, user_name, password, first_name, last_name, billing_address, delivery_address)
    error_message = ""

    begin
      user = self.find(id)
      user.update({user_name: user_name, })
      success = true
    rescue Exception => e
      success = false
      error_message = e.message
    end

    return {success: success, error_message: error_message}
  end

end
