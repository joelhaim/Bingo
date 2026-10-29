# My Bingo Card

A 4x4 bingo card you fill in yourself. Installable PWA, works offline, and syncs your cards through Supabase when you sign in with your email.

- `index.html` – the app
- `config.js` – Supabase URL + anon key (safe to publish; Row Level Security keeps cards private)
- `supabase.js` – supabase-js 2.45.4, bundled so the app works offline
- `schema.sql` – the `cards` table and its security policies
- `sw.js`, `manifest.json`, `icon-*.png` – PWA files
