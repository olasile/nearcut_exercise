import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "message" ]

    connect() {
        this.clearFlash = this.clearFlash.bind(this);
        addEventListener('turbo:before-fetch-request', this.clearFlash)
    }

    disconnect() {
        removeEventListener('turbo:before-fetch-request', this.clearFlash)
    }

    clearFlash() {
        this.messageTarget.innerHTML = "";
    }
}