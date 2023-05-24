# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  # to make sign in and sign out work for both webauthn and password
  # follow the signature: https://github.com/heartcombo/devise/blob/main/lib/devise/controllers/sign_in_out.rb#L33
  def sign_in(resource_or_scope, *args)
    resource = args.last || resource_or_scope
    session[:user_id] = resource.id
  end

  def sign_out(resource_or_scope = nil)
    return sign_out_all_scopes unless resource_or_scope

    scope = Devise::Mapping.find_scope!(resource_or_scope)
    user = warden.user(scope: scope, run_callbacks: false) # If there is no user

    warden.logout(scope)
    warden.clear_strategies_cache!(scope: scope)
    instance_variable_set(:"@current_#{scope}", nil)

    !!user

    session[:user_id] = nil
  end

  def current_user
    @current_user ||=
      if session[:user_id]
        User.find_by(id: session[:user_id])
      end
  end
end
