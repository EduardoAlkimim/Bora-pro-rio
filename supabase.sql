-- Bora pro Rio: cole no SQL Editor do Supabase e clique em Run.
-- Os lugares da lista inicial (places-seed.json) o próprio site coloca no banco.
create table if not exists places (id text primary key default gen_random_uuid()::text, name text not null, category text not null default 'postal', area text default '', note text default '', link text default '', added_by text default '', added_by_name text default '', created_at timestamptz not null default now());
create table if not exists votes (place_id text not null references places(id) on delete cascade, voter_id text not null, voter_name text not null default '', created_at timestamptz not null default now(), primary key (place_id, voter_id));
alter table places enable row level security;
alter table votes enable row level security;
drop policy if exists "ler lugares" on places;
drop policy if exists "adicionar lugares" on places;
drop policy if exists "remover lugares" on places;
drop policy if exists "ler votos" on votes;
drop policy if exists "votar" on votes;
drop policy if exists "tirar voto" on votes;
drop policy if exists "trocar nome" on votes;
create policy "ler lugares" on places for select to anon using (true);
create policy "adicionar lugares" on places for insert to anon with check (true);
create policy "remover lugares" on places for delete to anon using (added_by <> 'lista');
create policy "ler votos" on votes for select to anon using (true);
create policy "votar" on votes for insert to anon with check (true);
create policy "tirar voto" on votes for delete to anon using (true);
create policy "trocar nome" on votes for update to anon using (true) with check (true);
