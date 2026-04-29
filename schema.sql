-- BIN-GO Database Schema
-- Run this in your Supabase SQL editor

-- Scans table: every barcode scan event
create table if not exists scans (
  id                uuid primary key default gen_random_uuid(),
  ticket_id         text unique not null,
  barcode           text not null,
  format            text,
  lat               double precision,
  lng               double precision,
  accuracy_metres   integer,
  scanned_at        timestamptz not null default now(),
  device_id         text,
  email             text,
  created_at        timestamptz default now()
);

-- Email captures: optional deferred registration
create table if not exists email_captures (
  id           uuid primary key default gen_random_uuid(),
  email        text not null,
  device_id    text,
  captured_at  timestamptz not null default now()
);

-- Indexes for common queries
create index if not exists scans_scanned_at_idx on scans(scanned_at desc);
create index if not exists scans_barcode_idx on scans(barcode);
create index if not exists scans_device_id_idx on scans(device_id);

-- FMCG report view: scan counts by barcode (product) and area
create or replace view fmcg_disposal_report as
select
  barcode,
  format,
  count(*) as total_disposals,
  round(avg(lat)::numeric, 3) as avg_lat,
  round(avg(lng)::numeric, 3) as avg_lng,
  date_trunc('day', scanned_at) as disposal_date,
  count(distinct device_id) as unique_users
from scans
group by barcode, format, date_trunc('day', scanned_at)
order by disposal_date desc, total_disposals desc;

-- Council report view: disposal events by approximate location (50m grid)
create or replace view council_disposal_report as
select
  round(lat::numeric, 3) as lat_grid,
  round(lng::numeric, 3) as lng_grid,
  count(*) as total_disposals,
  count(distinct barcode) as unique_products,
  count(distinct device_id) as unique_users,
  date_trunc('day', scanned_at) as disposal_date
from scans
where lat is not null and lng is not null
group by round(lat::numeric, 3), round(lng::numeric, 3), date_trunc('day', scanned_at)
order by disposal_date desc, total_disposals desc;
