{% snapshot securities_master_snapshot %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='security_id',
        strategy='timestamp',
        updated_at='updated_at',
        tags=['snapshots', 'securities']
    )
}}

select
    security_id,
    isin,
    cusip,
    ticker,
    security_name,
    asset_class,
    currency,
    country,
    sector,
    market_cap_category,
    exchange,
    current_timestamp() as updated_at
from {{ source('raw_data', 'SECURITIES_MASTER') }}

{% endsnapshot %}