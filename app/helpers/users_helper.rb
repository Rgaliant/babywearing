# frozen_string_literal: true

module UsersHelper
  def user_initials(user)
    first_initial = user.first_name[0]
    last_initial = user.last_name[0]
    user_initials = `#{first_initial}#{last_initial}`
  end

  def user_can_add_new_member(user)
    user.has_role?(:admin) || user.has_role?(:volunteer)
  end 
end
