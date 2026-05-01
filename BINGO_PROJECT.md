# BIN-GO Project Summary
*Last updated: May 2026*

---

## The Concept

BIN-GO is a consumer-facing mobile app that rewards anyone for putting litter in a bin. Users scan the GS1 barcode on FMCG packaging when disposing of it, generating a unique prize draw ticket. GPS captures the bin location automatically.

**Working tagline:** Bin to Win

---

## The Three Stakeholders

1. **Consumers** — scan packaging when binning, earn prize draw tickets, win prizes
2. **FMCG brands** — disposal location data for EPR (Extended Producer Responsibility) compliance
3. **Councils** — bin usage patterns, litter hotspot data, compliance reporting

---

## Key Product Decisions

### Progressive Registration
- Users scan anonymously by default (device token)
- Scans build up as tickets without any login friction
- Email only captured optionally — deferred until prize claim
- Anonymous history merges into account at registration point
- Legally compliant — identity only verified at prize claim

### Prize Draw
- Free to enter, no purchase necessary (UK regulations)
- T&Cs accessible from scan screen
- One ticket per scan
- Prize draw structure TBD — needs to feel genuinely winnable across all demographics

### Litter Picking
- App works for both own packaging AND found litter
- No differentiation in reward — equal tickets for both
- Inspired by Romania's RVM scheme where homeless communities became active participants
- Social impact story: engages demographics other apps ignore

### Unique Scan Integrity
- Problem: people could scan same wrapper multiple times
- Short term: duplicate ticket ID detection
- Medium term: perceptual hash of item photo (edge AI on device)
- Long term: GS1 2D barcodes provide unique item-level identification
- Hash checked server-side (not just device) to prevent passing wrapper to friends
- Photo as proof of disposal = premium compliance tier for brands/councils (phase 2)

---

## Brand

- **Name:** BIN-GO
- **Tagline:** Bin to Win (working, to be refined)
- **Mode:** Light (not dark)
- **Primary colour:** Green (exact shade TBD)
- **Tone:** Fun, rewarding, not preachy or eco-guilt
- **Primary audience:** 16-35 urban, smartphone native, responds to gamification
- **Secondary audience:** Everyone — 49% of UK adults admit to littering

### Research Findings
- No single "littering demographic" — it's a mass market problem
- Younger people litter more but everyone does it
- Prize draws work when communication is clear and participation is frictionless
- BIN-GO's superpower: lowest possible friction — scan, ticket, done
- Behaviour change driven by reward not shame

---

## Tech Stack (Current PWA)

| Layer | Technology |
|-------|-----------|
| Frontend | Vanilla HTML/CSS/JS PWA |
| Hosting | Vercel (free tier) |
| Database | Supabase (PostgreSQL, free tier) |
| Barcode scanning | BarcodeDetector API (Android) / Manual entry (iPhone) |
| GPS | Browser Geolocation API |
| Repo | GitHub (bingo-app) |

### Live URLs
- **App:** https://bingo-app-steel.vercel.app
- **FMCG Report:** https://bingo-app-steel.vercel.app/report.html

### Supabase
- Project ID: moaszzhcqnhhlemdgurq
- URL: https://moaszzhcqnhhlemdgurq.supabase.co
- RLS: disabled (to be enabled before production)

---

## Database Schema

### Tables
- **scans** — every barcode scan event (ticket_id, barcode, format, lat, lng, accuracy_metres, scanned_at, device_id, email)
- **email_captures** — optional deferred registration (email, device_id, captured_at)

### Report Views
- **fmcg_disposal_report** — disposal counts by product and day
- **council_disposal_report** — disposal hotspots by GPS grid

### Nation Detection
GPS coordinates automatically mapped to England / Scotland / Wales / Northern Ireland for EPR compliance reporting.

---

## What's Working (PWA MVP)

- ✅ Barcode entry (manual + Android camera scan)
- ✅ GPS location capture
- ✅ Unique ticket generation (BG-YEAR-RAND-SEQ format)
- ✅ Saving to Supabase
- ✅ Email capture (linked to all device scans)
- ✅ Progressive registration flow
- ✅ FMCG EPR compliance report with CSV download
- ✅ Nation detection from GPS
- ✅ Date/nation/barcode filters on report

## What's Not Working Yet (PWA)

- ❌ iPhone camera barcode scanning (Safari restrictions) — React Native will fix this
- ❌ Automated emails (need Resend or similar)
- ❌ Unique scan verification (perceptual hash)
- ❌ RLS security (needed before production)
- ❌ Prize draw management
- ❌ Full branding/colours

---

## Next Phase: React Native App

### Why React Native
- Native camera access — barcode scanning works perfectly on both iOS and Android
- On-device AI for perceptual hashing (TensorFlow Lite / ONNX)
- Single codebase for iOS and Android
- App Store distribution

### Build Plan
1. React Native scaffold + navigation
2. Camera + GS1 barcode scanning
3. GPS integration (already solved, port from PWA)
4. Ticket generation + Supabase connection (port from PWA)
5. Edge AI perceptual hashing (unique scan verification)
6. Server-side hash uniqueness check
7. Progressive registration flow
8. FMCG report (already built, accessible via browser)
9. Branding + polish (light mode, final colours, logo)
10. App Store submission prep

### Estimated Build (with Claude)
~6-8 sessions

---

## Compliance Notes

- Free to enter, no purchase necessary
- 18+, UK residents (for prize draw)
- T&Cs linked from scan screen
- Privacy policy linked from email capture
- Identity verification only required at prize claim
- EPR data: GTIN + GPS + timestamp + nation = compliant disposal record
- GDPR: email stored securely, only used for prize notification
- RLS to be enabled on Supabase before production launch
- Photo storage (phase 2): GDPR review needed if people visible in photos

---

## Future Roadmap

- [ ] React Native app (iOS + Android)
- [ ] Perceptual hash unique scan verification
- [ ] Automated winner notification emails (Resend)
- [ ] Prize draw management dashboard
- [ ] FMCG brand portal (login, filtered to own products)
- [ ] Council map dashboard
- [ ] Photo proof of disposal (premium compliance tier)
- [ ] Push notifications
- [ ] Social sharing (scan streaks, leaderboards)
- [ ] GS1 Digital Link resolver (product name lookup from GTIN)
- [ ] Offline mode with sync queue

---

## Business Model (emerging)

- **FMCG brands** pay for compliance data access / reporting
- **Councils** pay for disposal hotspot data
- **Prize draw** funded by brand sponsors (product placement / brand prizes)
- **Premium tier** — photo proof of disposal for brands needing audit trail

---

*Built with Claude in one session. Developer: Claude. Client: You. 😄*
