// ==UserScript==
// @name         Ligonier Favicon
// @version      0.1
// @description  Locally change the favicon for ligonier.com
// @author       @eboodnero
// @grant        none
// ==/UserScript==

(function() {
    var link = document.querySelector("link[rel*='icon']") || document.createElement('link');
    link.type = 'image/x-icon';
    link.rel = 'shortcut icon';
    link.href = 'https://raw.githubusercontent.com/eboody/AHK/master/Icons/favicon.ico';
    document.getElementsByTagName('head')[0].appendChild(link);
})();