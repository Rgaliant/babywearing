# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:member) { users(:member) }
  let(:admin) { users(:admin) }

  context 'Associations' do
    it 'is a member' do
      expect(member).to have_role(:member)
    end
  end

    it 'should be a member' do
      user = User.create!(
        email: "alicia@test.com",
        password: "123abc",
        first_name: "Alicia",
        last_name: "Barrett",
        street_address: "123 street",
        city: "Atlanta",
        state: "GA",
        postal_code: "30030",
        phone_number: "909-851-9806"
      )
    end
    
  context 'Users can be activated and deactivated' do
    it 'defaults to activated' do
      expect(member).not_to be_deactivated
      expect(member).to be_activated
    end

    it 'can be deactivated' do
      member.deactivate
      expect(member).to be_deactivated
      expect(member).not_to be_activated
    end

    it 'can be reactivated' do
      member.activate
      expect(member).not_to be_deactivated
      expect(member).to be_activated
    end
  end
end
