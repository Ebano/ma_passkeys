WebAuthn.configure do |config|
  config.origin = ENV["WEBAUTHN_ORIGIN"]
  config.rp_name = "Easy Auth"
end
