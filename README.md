# My Bingo Card

A 4x4 bingo card you fill in yourself. Installable PWA, works offline, and syncs your cards through Supabase using a personal code: type the same code on any device to get your cards.

- `index.html` – the app
- `config.js` – Supabase URL + anon key (safe to publish; Row Level Security keeps cards private)
- `supabase.js` – supabase-js 2.45.4, bundled so the app works offline
- `schema.sql` – the `code_cards` table (cards saved under a hashed personal code)
- `sw.js`, `manifest.json`, `icon-*.png` – PWA files
