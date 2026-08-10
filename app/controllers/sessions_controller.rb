class SessionsController < Devise::SessionsController
  private

  def after_sign_out_path_for(_resource_or_scope)
    login_path
  end
end
