require 'spec_helper'
require 'rails_helper'
require 'devise'

describe CakesController do
  login_user
  context "shows a list of cakes" do
    it "assigns all cakes as @cakes" do
      cake = Cake.create!(name: 'ciasto', kind: 'tasty', description: 'pyszne ciasto')
      get :index
      expect(assigns(:cakes)).to eq([cake])
    end
    it "renders index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
  context "shows creating new cake page" do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  context "create cake with valid attributes" do
    it "saves a new cake" do
      parameters = {cake: { name: 'ciasto', kind: 'tasty', description: 'pyszne ciasto' } }
      expect{ post :create, parameters}.to change(Cake, :count).by(1)
      expect(response).to redirect_to(root_path)
    end
  end
  context "create cake with invalid attributes" do
    it "does not save the new cake" do
      parameters = {cake: { name: 'ciasto', kind: 'non', description: 'pyszne ciasto' } }
      expect{ post :create, parameters}.to_not change(Cake, :count)
    end
  end
end