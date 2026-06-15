#!/usr/bin/env python3
"""Generate Hugo data file from pdd_goods.json (real Pinduoduo products)"""
import json, os

goods_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', 'pdd_goods.json')
with open(goods_file, 'r', encoding='utf-8') as f:
    goods = json.load(f)

links = []
for g in goods:
    links.append({
        'id': g['id'],
        'name': g['name'],
        'desc': g.get('desc', g['name'])[:80],
        'link': g.get('promotion_url', f"https://mobile.yangkeduo.com/goods.html?goods_id={g['id']}"),
        'price': g.get('price', 0),
        'coupon': g.get('coupon', 0),
        'commission_rate': g.get('commission_rate', 0),
        'sales': g.get('sales', ''),
        'image': g.get('image', ''),
        'category': g.get('category', ''),
    })

# write to Hugo data
os.makedirs('hugo_site/data', exist_ok=True)
with open('hugo_site/data/links.json', 'w', encoding='utf-8') as f:
    json.dump(links, f, ensure_ascii=False, indent=2)
print(f"Generated {len(links)} affiliate links.")
