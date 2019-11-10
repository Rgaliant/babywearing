# frozen_string_literal: true

class LoanPolicy < ApplicationPolicy
  attr_reader :user, :loan

  def initialize(user, loan)
    @user = user
    @loan = loan
  end

  def new?
    authorized?
  end

  def create?
    authorized?
  end

  private

  def authorized?
    user.admin? || user.volunteer?
  end
end
