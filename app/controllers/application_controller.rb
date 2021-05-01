class ApplicationController < ActionController::Base
  include Pundit
  include ExceptionHandler

  before_action :authenticate_user!
  protect_from_forgery
end
