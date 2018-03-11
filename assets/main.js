function flip() {
    "use strict";
    this.classList.toggle("hover");
}

document.getElementsByClassName("flip-container").addEventListener("ontouchstart", flip, false);
