class ApplicationController < ActionController::Base

  # Pundit
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Set Layout
  layout :layout_by_resource

  # Manage Pundit Errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  # Layout per resource_name
def layout_by_resource
  if devise_controller? && resource_name == :admin
    "backoffice_devise"
  else
    "application"
  end
end

def user_not_authorized
    flash[:alert] = "Você não está autorizado para executar esta ação."
    redirect_to(request.referrer || root_path)
  end

end
