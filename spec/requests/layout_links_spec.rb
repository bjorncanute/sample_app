require 'spec_helper'

describe "LayoutLinks" do

	it "should have a Home page at '/'" do
		get '/'
		response.should have_selector('title', :content => "Home")
	end

	it "should have a Contact page at '/contact'" do
		get '/contact'
		response.should have_selector('title', :content => "Contact")
	end

	it "should have an About page at '/about'" do
		get '/about'
		response.should have_selector('title', :content => "About")
	end

	it "should have a Help page at '/help'" do
		get '/help'
		response.should have_selector('title', :content => "Help")
	end

	it "should have a signup page at '/signup'" do
		get '/signup'
		response.should have_selector('title', :content => "Sign up")
	end

	it "should have a signin page at '/signin'" do
		get '/signin'
		response.should have_selector('title', :content => "Sign in")
	end

	it "should have the right links on the layout" do
		visit root_path
		response.should have_selector('title', :content => "Home")
		click_link "About"
		response.should have_selector('title', :content => "About")
		click_link "Contact"
		response.should have_selector('title', :content => "Contact")
		click_link "Home"
		response.should have_selector('title', :content => "Home")
		click_link "Sign up now!"
		response.should have_selector('title', :content => "Sign up")
		response.should have_selector('a[href="/"]>img')
	end

	describe "when not signed in" do
		it "should have a sign in link" do
			visit root_path
			response.should have_selector('a', :href => signin_path,
				    							:content => "Sign in")
		end
	end

	describe "when signed in" do

		before(:each) do
			@user = Factory(:user)
			visit signin_path
			fill_in :email,    :with => @user.email
			fill_in :password, :with => @user.password
			click_button
		end

		it "should have a signout link" do
			visit root_path
			response.should have_selector('a', :href => signout_path,
											   :content => "Sign out")
			
		end

		it "should have a profile link" do
			visit root_path
			response.should have_selector('a', :href => user_path(@user),
											   :content => "Profile")
		end
	end


	# In tutorial block is inside user_spec.rb: doesn't work there?
	describe "signin" do
	      
      describe "Failiure" do

        it "should not sign the user in" do
          visit signin_path
          fill_in "Email",    :with => ""
          fill_in "Password", :with => ""
          click_button
          response.should have_selector('div.flash.error', 
                                        :content => "Invalid")
          response.should render_template('sessions/new')
        end
      end

      describe "Success" do
      	it "should sign a user in and out" do
      		user = Factory(:user)
      		visit signin_path
      		fill_in "Email",    :with => user.email
      		fill_in "Password", :with => user.password
      		click_button
      		controller.should be_signed_in
      		click_link "Sign out"
      		controller.should_not be_signed_in
      	end
      end
    end
    # end of block




end
