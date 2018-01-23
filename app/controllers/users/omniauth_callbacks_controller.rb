module Users
  class OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
    include Devise::Controllers::Rememberable

    def omniauth_success
      get_resource_from_auth_hash
      create_token_info
      set_token_on_resource
      create_auth_params

      sign_in(:user, @resource, store: false, bypass: false)

      @resource.save!

      # update_auth_header
      response.headers.merge!(@resource.create_new_auth_token)

      yield @resource if block_given?

      render json: @resource, status: :ok
    end
  end
end
