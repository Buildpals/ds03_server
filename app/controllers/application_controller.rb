# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  # The callback which stores the current location must be added before you authenticate the user
  # as `authenticate_user!` (or whatever your resource is) will halt the filter chain and redirect
  # before the location can be stored.

  before_action :authenticate_user!

  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.find(session[:cart_id])
      session[:cart_id] = nil if @current_cart.paid_at
    end
    create_cart if session[:cart_id].nil?
    @current_cart
  rescue ActiveRecord::RecordNotFound
    create_cart
  end

  helper_method :current_cart

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[full_name phone_number])
  end

  private

  def create_cart
    @current_cart = Cart.create!(user: current_user)
    session[:cart_id] = @current_cart.id
    @current_cart
  end

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end
end
