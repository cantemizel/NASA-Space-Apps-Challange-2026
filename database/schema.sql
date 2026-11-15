-- SPHEREx exact source PostgreSQL table schema introspected from running project.

-- Use only on a NEW, EMPTY PostgreSQL database.

CREATE TABLE IF NOT EXISTS "spherex_catalog_cache" (
  "cache_key" text NOT NULL,
  "target_id" text,
  "ra_deg" double precision NOT NULL,
  "dec_deg" double precision NOT NULL,
  "detector" text NOT NULL,
  "result_json" jsonb NOT NULL,
  "cached_at" timestamp with time zone NOT NULL DEFAULT now(),
  "fresh_until" timestamp with time zone NOT NULL DEFAULT (now() + '24:00:00'::interval),
  CONSTRAINT "spherex_catalog_cache_pkey" PRIMARY KEY (cache_key)
);

CREATE TABLE IF NOT EXISTS "spherex_processed_frames" (
  "cache_key" text NOT NULL,
  "target_id" text,
  "observed_utc" timestamp with time zone,
  "source_url" text NOT NULL,
  "preview_png" text NOT NULL,
  "science_gzip" text NOT NULL,
  "source_sha256" text NOT NULL,
  "native_width" integer NOT NULL,
  "native_height" integer NOT NULL,
  "valid_fraction" double precision NOT NULL,
  "wave_center_um" double precision,
  "notes" text NOT NULL DEFAULT ''::text,
  "created_at" timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "spherex_processed_frames_pkey" PRIMARY KEY (cache_key)
);

CREATE TABLE IF NOT EXISTS "spherex_reports" (
  "report_key" text NOT NULL,
  "target_id" text NOT NULL,
  "report_json" jsonb NOT NULL,
  "created_at" timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "spherex_reports_pkey" PRIMARY KEY (report_key)
);

CREATE TABLE IF NOT EXISTS "spherex_targets" (
  "id" text NOT NULL,
  "label_tr" text NOT NULL,
  "label_en" text NOT NULL,
  "object_type" text NOT NULL,
  "ra_deg" double precision NOT NULL,
  "dec_deg" double precision NOT NULL,
  "detector" text NOT NULL DEFAULT 'SPHEREx-D2'::text,
  "description_tr" text NOT NULL DEFAULT ''::text,
  "bundled_zip" boolean NOT NULL DEFAULT false,
  "available_count" integer,
  "cached_frame_count" integer NOT NULL DEFAULT 0,
  "catalog_source" text,
  "last_checked_at" timestamp with time zone,
  "newest_observation_at" timestamp with time zone,
  "updated_at" timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "spherex_targets_dec_deg_check" CHECK (((dec_deg >= ('-90'::integer)::double precision) AND (dec_deg <= (90)::double precision))),
  CONSTRAINT "spherex_targets_pkey" PRIMARY KEY (id),
  CONSTRAINT "spherex_targets_ra_deg_check" CHECK (((ra_deg >= (0)::double precision) AND (ra_deg <= (360)::double precision)))
);

CREATE INDEX IF NOT EXISTS idx_spherex_catalog_cache_expiry ON public.spherex_catalog_cache USING btree (fresh_until);

CREATE INDEX IF NOT EXISTS idx_spherex_frames_target ON public.spherex_processed_frames USING btree (target_id, observed_utc DESC);
