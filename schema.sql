-- Bingo cards, one row per card, private to the signed-in owner.
create table if not exists public.cards (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title text not null default 'My Bingo',
  items jsonb not null default '[]'::jsonb,
  marks jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);
create index if not exists cards_user_updated on public.cards (user_id, updated_at desc);

alter table public.cards enable row level security;

drop policy if exists "own cards select" on public.cards;
drop policy if exists "own cards insert" on public.cards;
drop policy if exists "own cards update" on public.cards;
drop policy if exists "own cards delete" on public.cards;
create policy "own cards select" on public.cards for select to authenticated using (user_id = (select auth.uid()));
create policy "own cards insert" on public.cards for insert to authenticated with check (user_id = (select auth.uid()));
create policy "own cards update" on public.cards for update to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "own cards delete" on public.cards for delete to authenticated using (user_id = (select auth.uid()));
