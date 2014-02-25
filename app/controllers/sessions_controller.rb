class SessionsController < ApplicationController

  def new
  	@title = "Sign in"
  end

  def create
  	user = User.authenticate(params[:session][:email],
  		                    params[:session][:password])
  	if user.nil?
  		flash.now[:error] = "Invalid Email/password combination."
  		@title = "Sign in"
	  	render 'new'
	else
		# Handle successful signin.
	end
  end
  def destory 

  end
end