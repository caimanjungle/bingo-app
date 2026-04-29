# BIN-GO 🎯

> Bin it. Track it. Win it.

A mobile PWA that lets consumers scan GS1 barcodes on FMCG packaging when disposing of litter in a bin. Captures product identity, GPS location, and timestamp — generating a unique prize draw ticket per scan.

## Stakeholders

- **Consumers** — scan to earn prize draw tickets (progressive registration)
- **FMCG producers** — disposal location data for EPR compliance
- **Councils** — bin usage and litter hotspot data

## Stack

- **Frontend**: Vanilla HTML/CSS/JS PWA (no build step required)
- **Database**: Supabase (PostgreSQL)
- **Hosting**: Vercel
- **Barcode scanning**: ZXing (GS1, QR, DataMatrix, EAN, etc.)

## Setup

### 1. Supabase

1. Create a project at [supabase.com](https://supabase.com)
2. Go to **SQL Editor** and run the contents of `schema.sql`
3. Note your **Project URL** and **anon key** from Settings → API Keys

### 2. Configure the app

In `index.html`, update these two lines:

```js
const SUPABASE_URL = 'your-project-url';
const SUPABASE_KEY = 'your-anon-key';
```

### 3. Deploy to Vercel

1. Push this repo to GitHub
2. Go to [vercel.com](https://vercel.com) → New Project → Import your GitHub repo
3. Click Deploy — no build settings needed

### 4. Test on your phone

Visit your Vercel URL on a phone → tap the share button → "Add to Home Screen" to install as a PWA.

## Database Tables

| Table | Purpose |
|-------|---------|
| `scans` | Every barcode scan event with GPS + timestamp |
| `email_captures` | Optional email from deferred registration |

## Report Views

| View | Purpose |
|------|---------|
| `fmcg_disposal_report` | Product disposal counts by day for FMCG producers |
| `council_disposal_report` | Disposal hotspots by GPS grid for councils |

## Roadmap

- [ ] FMCG producer dashboard
- [ ] Council map dashboard  
- [ ] Prize draw management
- [ ] Push notifications for winners
- [ ] Batch upload for offline scans
- [ ] GS1 Digital Link resolver (product name lookup)

## Compliance

- Free to enter, no purchase necessary
- T&Cs linked from scan screen
- Privacy policy linked from email capture
- Progressive registration — only required at prize claim
- Data retained per UK GDPR requirements
