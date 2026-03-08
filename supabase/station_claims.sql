create table if not exists public.station_claims (
  world_seed text not null,
  station_id text not null,
  claimed_by text,
  claimed_at bigint,
  visited_count integer not null default 0,
  last_visited_at bigint,
  total_stay_ms integer not null default 0,
  updated_at bigint not null default (extract(epoch from now()) * 1000)::bigint,
  primary key (world_seed, station_id)
);

alter table public.station_claims enable row level security;

drop policy if exists "station_claims_read" on public.station_claims;
create policy "station_claims_read"
on public.station_claims
for select
to anon, authenticated
using (true);

drop policy if exists "station_claims_write" on public.station_claims;
create policy "station_claims_write"
on public.station_claims
for insert
to anon, authenticated
with check (true);

drop policy if exists "station_claims_update" on public.station_claims;
create policy "station_claims_update"
on public.station_claims
for update
to anon, authenticated
using (true)
with check (true);

alter publication supabase_realtime add table public.station_claims;