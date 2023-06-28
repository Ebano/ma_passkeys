import { Controller } from "stimulus";
import { supported as WebAuthnSupported } from "@github/webauthn-json";

export default class extends Controller {
  static targets = ["message"]

  connect() {

    if (!WebAuthnSupported()) {
      this.messageTarget.innerHTML = "This browser doesn't support WebAuthn API";
      this.element.classList.remove("hidden");
    } else {
      PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable().then((available) => {
        if (!available)  {
          if (document.querySelector("h1").innerHTML === "Welcome to Easy Auth") {
            window.location.href = "http://localhost:3000/users/sign_up"; // redirect to password sign up page
          } else {
            console.log("platform auth not available.")
            let div = document.createElement("div");
            div.innerHTML = "You currently can't register passkeys because there is no platform authenticator."
            document.getElementById("feat").appendChild(div);
          }
        }
      });
    }
  }
}
