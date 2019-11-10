# frozen_string_literal: true

class User < ApplicationRecord
  include Deactivable

  has_person_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :street_address, :city,
            :state, :postal_code, :phone_number, presence: true

  has_many :signed_agreements
  has_many :carts

  enum role: [:admin, :volunteer, :member]

  after_create :send_welcome_email

  def self.to_csv
    attributes = %w[first_name last_name email phone_number created_at]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end

  private

  def send_welcome_email
    WelcomeMailer.welcome_email(self).deliver
  end
end
