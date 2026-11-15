# Final backup scope and scientific integrity

- 217 Floot-native source files, SHA-256 checked against their original per-file read results.
- 4 original PostgreSQL data tables with 214 total records (19 + 19 + 114 + 62).
- 114 full processed PNG previews and JSON scientific grids, including wavelength/variance/ePSF where present.
- Database PostgreSQL schema rebuilt with actual constraints, defaults and indexes.
- Six public project assets saved at their original public storage filenames.
- All original NASA FITS source URLs and SHA-256 fields retained; **full raw FITS binaries are not included**.
- `science_gzip` values may be regenerated losslessly from normalized live science JSON; compression bytes may differ from originals.
- Floot runtime/compiler, cloud hosting accounts, database credentials, DNS and secret environment variables are NOT part of downloadable code. Those need configuration in a compatible Floot workspace.
- Historical notes under `docs/development-history` retain their original dated counts and may be older than the final snapshot.
- The project makes no claim of new astronomical detection or independently calibrated stellar photometry.
