-- INDOBONA FORTUNA MEMBER ONLINE
-- Jalankan seluruh SQL ini di Supabase SQL Editor

create table if not exists public.members (
  id text primary key,
  code text unique not null,
  name text not null,
  phone text not null,
  email text,
  branch text not null,
  joined_at timestamptz,
  points integer not null default 0,
  total_spend numeric not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.transactions (
  id text primary key,
  member_code text not null,
  member_name text not null,
  type text not null,
  amount numeric not null default 0,
  points integer not null default 0,
  branch text not null,
  note text,
  cashier text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.vouchers (
  id text primary key,
  member_code text not null,
  member_name text not null,
  points integer not null,
  value numeric not null,
  note text,
  created_at timestamptz not null default now()
);

create table if not exists public.app_settings (
  id text primary key,
  points_per_amount integer not null default 1,
  amount_per_point integer not null default 10000,
  registration_bonus integer not null default 20,
  redeem_rate_points integer not null default 100,
  redeem_value integer not null default 10000,
  tiers_json jsonb not null default '[
    {"name":"Bronze","minPoints":0},
    {"name":"Silver","minPoints":300},
    {"name":"Gold","minPoints":1000},
    {"name":"Platinum","minPoints":2500}
  ]'::jsonb,
  branches_json jsonb not null default '["Palangka Raya","Banjarmasin","Sampit"]'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists public.staff_users (
  id text primary key,
  username text unique not null,
  password text not null,
  role text not null,
  branch text not null,
  created_at timestamptz not null default now()
);

insert into public.app_settings (
  id, points_per_amount, amount_per_point, registration_bonus, redeem_rate_points, redeem_value
)
values ('main', 1, 10000, 20, 100, 10000)
on conflict (id) do nothing;

insert into public.staff_users (id, username, password, role, branch)
values
('admin-main', 'admin', 'admin123', 'admin', 'Palangka Raya'),
('kasir-main', 'kasir1', 'kasir123', 'kasir', 'Palangka Raya')
on conflict (username) do nothing;

insert into public.members (
  id, code, name, phone, email, branch, joined_at, points, total_spend, created_at
)
values (
  'member-sample-1', 'IBF-0001', 'Budi Santoso', '081234567890', '', 'Palangka Raya',
  now(), 245, 2450000, now()
)
on conflict (code) do nothing;

insert into public.transactions (
  id, member_code, member_name, type, amount, points, branch, note, cashier, created_at
)
values (
  'trx-sample-1', 'IBF-0001', 'Budi Santoso', 'earn', 250000, 25, 'Palangka Raya', 'Belanja helm', 'admin', now()
)
on conflict (id) do nothing;

alter table public.members enable row level security;
alter table public.transactions enable row level security;
alter table public.vouchers enable row level security;
alter table public.app_settings enable row level security;
alter table public.staff_users enable row level security;

drop policy if exists "allow all members" on public.members;
drop policy if exists "allow all transactions" on public.transactions;
drop policy if exists "allow all vouchers" on public.vouchers;
drop policy if exists "allow all settings" on public.app_settings;
drop policy if exists "allow all staff" on public.staff_users;

create policy "allow all members" on public.members for all using (true) with check (true);
create policy "allow all transactions" on public.transactions for all using (true) with check (true);
create policy "allow all vouchers" on public.vouchers for all using (true) with check (true);
create policy "allow all settings" on public.app_settings for all using (true) with check (true);
create policy "allow all staff" on public.staff_users for all using (true) with check (true);


alter table public.staff_users add column if not exists permissions_json jsonb;

update public.staff_users
set permissions_json = case
  when role = 'super_admin' then '{"dashboard":true,"members":true,"add_member":true,"delete_member":true,"transactions":true,"add_transaction":true,"voucher":true,"scanner":true,"export":true,"settings":true,"branches_manage":true,"users_manage":true}'::jsonb
  when role = 'admin' then '{"dashboard":true,"members":true,"add_member":true,"delete_member":false,"transactions":true,"add_transaction":true,"voucher":true,"scanner":true,"export":true,"settings":true,"branches_manage":false,"users_manage":true}'::jsonb
  else '{"dashboard":false,"members":true,"add_member":false,"delete_member":false,"transactions":true,"add_transaction":true,"voucher":true,"scanner":true,"export":false,"settings":false,"branches_manage":false,"users_manage":false}'::jsonb
end
where permissions_json is null;

insert into public.staff_users (id, username, password, role, branch, permissions_json)
values (
  'superadmin-main',
  'superadmin',
  'super123',
  'super_admin',
  'Palangka Raya',
  '{"dashboard":true,"members":true,"add_member":true,"delete_member":true,"transactions":true,"add_transaction":true,"voucher":true,"scanner":true,"export":true,"settings":true,"branches_manage":true,"users_manage":true}'::jsonb
)
on conflict (username) do nothing;


alter table public.members add column if not exists referred_by_code text;
alter table public.members add column if not exists referred_by_name text;

alter table public.app_settings add column if not exists member_code_prefix text default 'IBF';
alter table public.app_settings add column if not exists member_code_separator text default '-';
alter table public.app_settings add column if not exists member_code_digits integer default 4;
alter table public.app_settings add column if not exists next_code_number integer default 1;

update public.app_settings
set member_code_prefix = coalesce(member_code_prefix, 'IBF'),
    member_code_separator = coalesce(member_code_separator, '-'),
    member_code_digits = coalesce(member_code_digits, 4),
    next_code_number = coalesce(next_code_number, 1)
where id = 'main';

alter table public.transactions add column if not exists referred_by_code text;
alter table public.transactions add column if not exists referred_by_name text;
