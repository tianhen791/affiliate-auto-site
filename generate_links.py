#!/usr/bin/env python3
import yaml, json, csv, os
config = yaml.safe_load(open('config.yaml'))
BASE = config['affiliate_base']
links=[]
with open(config['product_list']) as f:
    for row in csv.DictReader(f):
        prod_id=row['id']
        link = f"{BASE}{prod_id}"
        links.append({
            'id': prod_id,
            'name': row['name'],
            'desc': row['description'],
            'link': link
        })
# write to Hugo data
os.makedirs('hugo_site/data', exist_ok=True)
open('hugo_site/data/links.json','w').write(json.dumps(links, indent=2))
print(f"Generated {len(links)} affiliate links.")
