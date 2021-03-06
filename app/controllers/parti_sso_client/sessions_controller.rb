module PartiSsoClient
  class SessionsController < Devise::CasSessionsController
    include PartiSsoClient::Authentication

    # Skip redirect_to_sign_in to fix
    # flash message not showing up in Rails 4
    # (https://github.com/nbudin/devise_cas_authenticatable/issues/81)

    skip_before_filter :redirect_to_sign_in,
    only: [:new, :destroy, :single_sign_out, :service, :unregistered]

    # Skip verify_signed_out_user for Devise >= 3.3.0
    skip_before_filter :verify_signed_out_user

    def after_sign_in_path_for(resource)
      after_sso_sign_in_path_for(resource) || super(resource)
    end
  end
end
