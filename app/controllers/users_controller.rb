class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.all.map { |user| user.to_pleasant_string }.join("\n")
  end

  def login
    email = params[:email]
    pass = params[:password]
    user = User.find_by(email: email)
    if user.nil?
      text = false
    elsif user.password == pass
      text = true
    else
      text = false
    end
    render plain: text
  end

  def create
    name = params[:name]
    mail = params[:email]
    pass = params[:password]
    new_user = User.create!(name: name, email: mail, password: pass)
    response_text = "The new user is created with id #{new_user.id}"
    render plain: response_text
  end
end
