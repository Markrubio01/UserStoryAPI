Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'user/register_user'
  get 'user/login_user'
  get 'user/get_user_data'
  post 'user/update_user_contact_info'
end
