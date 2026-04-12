self.importScripts("config.js");

var cacheName = "v" + serviceWorkerCacheVersion + ":static";

var STATIC_ASSETS = [
  "./index.html",
  "./manifest.json",
  "./config.js",
  "./css/layouts/side-menu.css",
  "./css/dmw-pwa.css",
  "./js/ui.js",
  "./pages/about.html",
  "./pages/page_1.html",
  "./pages/pure.html",
  "./pages/dog.html",
  "./pages/pwa.html",
  "./dmw.html",
  "./img/favicon.png",
  "./img/icon_120.png",
  "./img/icon_180.png",
  "./img/icon_192.png",
  "./img/icon_512.png"
];

self.addEventListener("install", function (event) {
  event.waitUntil(
    caches.open(cacheName).then(function (cache) {
      return cache.addAll(STATIC_ASSETS);
    })
  );
  self.skipWaiting();
});

self.addEventListener("activate", function (event) {
  event.waitUntil(
    caches.keys().then(function (keyList) {
      return Promise.all(
        keyList.map(function (key) {
          if (key !== cacheName) return caches.delete(key);
        })
      );
    })
  );
  self.clients.claim();
});

self.addEventListener("fetch", function (event) {
  event.respondWith(
    caches.match(event.request).then(function (response) {
      return response || fetch(event.request);
    })
  );
});
