-- Cards saved under a personal code (no email sign-in).
-- The code is never stored: only its SHA-256 hash. Codes are case-insensitive, min 6 chars.
-- RLS is on with no policies, so the table can't be read directly; the app uses the functions below.
create table if not exists public.code_cards (
  id uuid primary key default gen_random_uuid(),
  owner_hash text not null,
  title text not null default 'My Bingo',
  items jsonb not null default '[]'::jsonb,
  marks jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);
create index if not exists code_cards_owner_updated on public.code_cards (owner_hash, updated_at desc);
alter table public.code_cards enable row level security;
-- Functions: _code_hash(code), list_cards(code), save_card(code, id, title, items, marks), delete_card(code, id)
-- (applied as Supabase migration "code_cards_by_personal_code")
