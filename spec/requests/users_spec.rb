require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:user, 10)
      get '/api/v1/users'
    end
    
    it 'returns all users' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:my_user) { FactoryBot.create(:user) }

      before do
        post '/api/v1/users', params:
                          { user: {
                            email: my_user.email,
                            password: my_user.password,
                            username: my_user.username
                          } }
      end

      it 'returns the email' do
     
        expect(json['email']).to eq(my_user.email)
      end

      it 'returns the username' do
        expect(json['username']).to eq(my_user.username)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/users', params:
                          { user: {
                            email: '',
                            password: ''
                          } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /update' do
    context 'with valid parameters' do
      let!(:my_user) { FactoryBot.create(:user) }

      before do
        put "/api/v1/users/#{my_user.id}", params:
                          { user: {
                            email: my_user.email,
                            password: my_user.password,
                            username: my_user.username
                          } }
      end

      it 'returns the email' do
  
        expect(json["user"]['email']).to eq(my_user.email)
      end

      it 'returns the username' do
        
        expect(json["user"]['username']).to eq(my_user.username)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/users', params:
                          { user: {
                            email: '',
                            password: ''
                          } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:user) { FactoryBot.create(:user) }

    before do
      delete "/api/v1/users/#{user.id}"
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    let!(:user) { FactoryBot.create(:user) }

    before do
      get "/api/v1/users/#{user.id}"
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end