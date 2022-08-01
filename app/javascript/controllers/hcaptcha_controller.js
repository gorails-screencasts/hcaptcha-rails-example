import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.render()
  }

  disconnect() {
    this.element.replaceChildren()
  }

  render() {
    if (window.hasOwnProperty("hcaptcha")) {
      hcaptcha.render(this.element)
    }
  }
}
