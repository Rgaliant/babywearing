# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:admin)  { users(:admin) }
  let(:member) { users(:member) }

  describe 'GET /users' do
    it_behaves_like 'admin authorized-only resource', :get do
      let(:endpoint) { users_path }
    end

    it 'has http status 200' do
      sign_in users(:admin)
      get users_path

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /users/:id' do
    it_behaves_like 'admin authorized-only resource', :put do
      let(:endpoint) { user_path(member) }
      let(:params) { { user: { first_name: 'Test' } } }
    end

    let(:valid_attr) { { first_name: 'New' } }
    let(:invalid_attr) { { first_name: '' } }

    context 'with valid attributes' do
      it 'updates the user' do
        sign_in users(:admin)
        put user_path(member), params: { user: valid_attr }

        expect(flash[:notice]).to eq('User was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it "doesn't update the user" do
        sign_in users(:admin)
        put user_path(member), params: { user: invalid_attr }

        expect(response.body).to match(/prohibited this/)
      end
    end
  end
end
