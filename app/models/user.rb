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
    id = 0
    begin
      puts User.last.to_json
      user = self.find_by('user_name = ?', user_name)
      if(user.blank?)
        success = false
        error_message = "Username does not exists"
      else
        id = user['id']
        if(user['password'] == password)
          success = true
        else
          success = false
          error_message = "Password is incorrect"
        end
      end

    rescue Exception => e
      success = false
      error_message = e.message
    end

    return {success: success, error_message: error_message, id: id}
  end

  def self.update_user(id, user_name, password, first_name, last_name, billing_address, delivery_address)
    error_message = ""

    begin
      user = self.find(id)
      user.update({user_name: user_name, password: password})
      user_contact_info = UserContactInfo.find_by("user_id = ?", id)
      user_contact_info.update({first_name: first_name, last_name: last_name, billing_address: billing_address, delivery_address: delivery_address})
      success = true
    rescue Exception => e
      success = false
      error_message = e.message
    end

    return {success: success, error_message: error_message}
  end

  def self.get_user_data(id)
    data = {}
    error_message = ""
    begin
      user = self.find(id)

      user_contact_info = UserContactInfo.find_by("user_id = ?", user.id)
      if(user_contact_info.blank?)
        success = false
        error_message = "User Contact Info does not exists"
      else
        data = {
          id: user.id,
          user_name: user.user_name,
          password: user.password,
          first_name: user_contact_info["first_name"],
          last_name: user_contact_info["last_name"],
          billing_address: user_contact_info["billing_address"],
          delivery_address: user_contact_info["delivery_address"]
        }
        success = true
      end

    rescue Exception => e
      success = false
      error_message = e.message
    end

    return {success: success, error_message: error_message, data: data}
  end
end
