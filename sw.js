const C = "bingo-v2";
const F = ["./", "index.html", "config.js", "supabase.js", "manifest.json", "icon-192.png", "icon-512.png"];
self.addEventListener("install", e => { e.waitUntil(caches.open(C).then(c => c.addAll(F))); self.skipWaiting(); });
self.addEventListener("activate", e => {
  e.waitUntil(caches.keys().then(k => Promise.all(k.filter(x => x !== C).map(x => caches.delete(x)))));
  self.clients.claim();
});
// Same-origin files: network first so updates show up, cache as offline fallback.
// Cross-origin (Supabase, fonts, CDN): handled by the browser, except the CDN script which we cache.
self.addEventListener("fetch", e => {
  const u = new URL(e.request.url);
  if (e.request.method !== "GET") return;
  const sameOrigin = u.origin === location.origin;
  const cdn = u.hostname === "cdn.jsdelivr.net" || u.hostname.endsWith("gstatic.com") || u.hostname === "fonts.googleapis.com";
  if (!sameOrigin && !cdn) return;
  e.respondWith(
    fetch(e.request).then(res => {
      if (res.ok || res.type === "opaque") { const cp = res.clone(); caches.open(C).then(c => c.put(e.request, cp)); }
      return res;
    }).catch(() => caches.match(e.request).then(r => r || (sameOrigin ? caches.match("index.html") : undefined)))
  );
});
