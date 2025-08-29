# ChronoVolt — App Build System

## 📖 Overview
This repository is the **factory** of ChronoVolt.  
It packages assets and app code into distributable, validated builds.

---

## 🧰 Tools
- `preflight_validate_payload.bat` → Verifies payload integrity.  
- `build_and_split.bat` → Packages + splits release into parts.  
- `join_and_install.bat` → Reassembles and installs ChronoVolt to `C:\ChronoVolt\`.  
- `tools/` → Helper scripts (`preflight_validate_payload.ps1`, `split_file.ps1`).  

---

## 📦 Payload
- `payload/assets/` → Contains staged assets:  
  - `MASTER SVGS/` → 3 masters only.  
  - `SOUND_ASSETS/sfx/`, `SOUND_ASSETS/voices/`.  
  - `_previews/` (non-authoritative).  

---

## 🚀 Workflow
1. Sync latest assets here (from [`chronovolt-manifest-references-assets`](https://github.com/jonfahey2011-dot/chronovolt-manifest-references-assets)).  
2. Run `preflight_validate_payload.bat`.  
3. Run `build_and_split.bat <version> <partMB>`.  
   - Produces `.zip`, numbered `.zip.001 … .zip.N`, `checksums.sha256`, and `parts_list.txt`.  
4. Distribute `.zip.0xx` parts + `join_and_install.bat`.  
5. On target machine, run `join_and_install.bat` → installs to `C:\ChronoVolt\`.  

---

## 🖥️ Future Expansion
- Will house the **Electron + WebGL + PostFX runtime**.  
- App folder structure:  
  ```
  app/
    main.js
    preload.js
    renderer/
    package.json
  payload/
  tools/
  ```
- Build system ready to integrate app code with assets.  

---

## 🛰️ Status
This repo is **authoritative for packaging and release**.  
It turns ChronoVolt from memory+assets into a distributable application.
