# Database restore

This archive contains **all four tables** from the 2026-11-15 SPHEREx snapshot: 19 targets, 19 catalogue-cache rows, 114 processed science frames and 62 saved reports.

The **schema.sql is recreated from the original PostgreSQL catalog**, including data types, defaults, NOT NULL, primary keys, CHECK constraints, and two secondary indexes. It is suitable for creating a new empty database; do not run this on the live database.

From the extracted project root:

```bash
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f database/schema.sql
python -m pip install 'psycopg[binary]'
python scripts/restore_postgres.py --database-url "$DATABASE_URL" --directory database
python scripts/validate_science_snapshot.py
python scripts/verify_package.py
```

The restore script loads both plain JSONL files and gzipped target partitions (including report partitions), refuses to overwrite a populated table, and commits in one transaction.

**Snapshot distinction:** original FITS files are linked to NASA/IPAC, not stored in this ZIP. Published science JSON and preview PNGs are saved; some `science_gzip` fields are losslessly recompressed after normalized ePSF migration, not necessarily byte-identical to their original compressed PostgreSQL field. Consult `docs/BACKUP_FIDELITY.md`.

**Floot-specific runtime:** the source is a virtual Floot code tree. To run an independent deployment, recreate the compatible Floot environment, restore this PostgreSQL snapshot in a new database, upload the hosted assets and configure permitted environment resources. There is no supported standalone `npm start` in this export.
