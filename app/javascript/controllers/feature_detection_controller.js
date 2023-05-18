import { Controller } from "stimulus";
import { supported as WebAuthnSupported } from "@github/webauthn-json";

export default class extends Controller {
  static targets = ["message"]

  connect() {
    if (!WebAuthnSupported()) {
     // redirect to password sign up page
      this.messageTarget.innerHTML = "This browser doesn't support WebAuthn API";
      this.element.classList.remove("hidden");
    } else {
      PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable().then((available) => {
        if (!available) {
          this.messageTarget.innerHTML = "We couldn't detect a user-verifying platform authenticator";
          this.element.classList.remove("hidden");
          window.location.href = "https://example.com"; // redirect to password sign up page
        }
      });
    }
  }
}
