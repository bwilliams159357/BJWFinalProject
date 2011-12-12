require 'spec_helper'

describe PagesController do
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => "Home")
    end
  end
  
  describe "GET 'gpage'" do
    it "should be successful" do
      get 'gpage'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'gpage'
      response.should have_selector("title", :content => "Game Page")
    end
  end
  
  describe "GET 'cpanel'" do
    it "should be successful" do
      get 'cpanel'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'cpanel'
      response.should have_selector("title", :content => "Control Panel - Profile")
    end
  end
  
  describe "GET 'pagesearch'" do
    it "should be successful" do
      get 'pagesearch'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'pagesearch'
      response.should have_selector("title", :content => "Search")
    end
  end
  
  describe "GET 'friends'" do
    it "should be successful" do
      get 'friends'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'friends'
      response.should have_selector("title", :content => "Control Panel - Friends")
    end
  end
  
  describe "GET 'collections'" do
    it "should be successful" do
      get 'collections'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'collections'
      response.should have_selector("title", :content => "Control Panel - Collections")
    end
  end
end
