$(function () {
    $("#header-placeholder").load("../assets/jqueryLoad/header.html");
});
$(function () {
    $("#footer-placeholder").load("../assets/jqueryLoad/footer.html");
});

function loadBar() {
    $("#nav-placeholder").load("../assets/jqueryLoad/nav.html", setActive);
}

function setActive() {
    var aObjects = document.getElementById("nav-placeholder").getElementsByTagName("a");

    for (var i = 0; i < aObjects.length; i++) {
        if (document.location.href.indexOf(aObjects[i].href) >= 0) {
            aObjects[i].className = "active";
        }
    }
}

function countChar(val) {
        var len = val.value;
        if (len >= 2000) {
          val.value = val.value.substring(0, 2000);
        }
        if (len > 1700){
        $('#charNum').text(2000 - len);
        }
      };

function update() {
//        document.getElementById("charCounter").value = document.getElementById("subject").value + document.getElementById("body").value;
    $("#charCounter").val($("#subject").val().length + $("#body").val().length);
      };

function flip() {
    "use strict";
    this.classList.toggle("hover");
}

document.getElementsByClassName("flip-container").addEventListener("ontouchstart", flip, false);
