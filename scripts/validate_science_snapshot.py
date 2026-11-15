#!/usr/bin/env python3
"""Validate all 114 processed SPHEREx science and ePSF snapshots offline."""
from pathlib import Path
import gzip,base64,json,math
root=Path(__file__).resolve().parent.parent
paths=sorted((root/'database'/'spherex_processed_frames').glob('*.jsonl.gz'))
if not paths:raise SystemExit('Missing processed-frame backup shards')
frames=0;epsf=0;problems=[]
for path in paths:
    with gzip.open(path,'rt',encoding='utf-8') as f:
        for line_no,line in enumerate(f,1):
            if not line.strip():continue
            frames+=1
            try:
                row=json.loads(line)
                if not row.get('preview_png','').startswith('data:image/png;base64,'):raise ValueError('missing preview PNG')
                s=json.loads(gzip.decompress(base64.b64decode(row['science_gzip'])).decode('utf-8'))
                n=s['grid_size']
                if len(s['flux'])!=n*n or len(s['variance'])!=n*n:raise ValueError('wrong science grid shape')
                psf=s.get('psf')
                if psf and psf.get('status')=='measured-from-EPSF':
                    epsf+=1
                    diff=abs(2.35482*psf['sigma_native_pix']*6.15-psf['fwhm_arcsec_approx'])
                    if not math.isfinite(diff) or diff>0.004:raise ValueError('ePSF width inconsistent')
            except Exception as exc:problems.append(f'{path.name} line {line_no}: {exc}')
print(f'Processed science frames={frames}; ePSF frames={epsf}; errors={len(problems)}')
for x in problems[:20]:print(x)
if frames!=114 or problems:raise SystemExit(1)
