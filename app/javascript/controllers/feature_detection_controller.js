import { Controller } from "stimulus";
import { supported as WebAuthnSupported } from "@github/webauthn-json";

export default class extends Controller {
  static targets = ["message"]

  connect() {

    if (window.PublicKeyCredential &&
      PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable &&
      PublicKeyCredential.isConditionalMediationAvailable) {
        console.log("Conditional UI available")
      }

    if (!WebAuthnSupported()) {
      this.messageTarget.innerHTML = "This browser doesn't support WebAuthn API";
      this.element.classList.remove("hidden");
    } else {
      PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable().then((available) => {
        if (!available) {
          window.location.href = "http://localhost:3000/users/sign_up"; // redirect to password sign up page
        }
      });
    }
  }
}
