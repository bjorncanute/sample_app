require 'spec_helper'

describe SessionsController do
	render_views

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
    	get :new
    	response.should have_selector('title', :content => "Sign in")
    end
  end
  describe "POST 'create'" do
    describe "Failure" do
      before(:each) do
        # @attr = { :email => "name@example.com", :password => "foobar" }
        @attr = { :email => "", :password => "" }
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should have an error message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end

      it "should still have the right title" do
        post :create, :session => @attr
        response.should have_selector('title', :content => "Sign in")
      end
    end
  
  end
end