{{
    config(
        schema='BRONZE',
        materialized='view',
        tags=['Bronze', 'securities']
    )
}}

-- Clean and type securities master data from raw source
with source as (
    select * from {{ source('raw_data', 'SECURITIES_MASTER') }}
),

renamed as (
    select
        -- Primary key
        security_id,
        
        -- Identifiers
        isin,
        cusip,
        ticker,
        security_name,
        
        -- Classifications
        asset_class,
        sector,
        market_cap_category,
        
        -- Geographic
        country,
        exchange,
        
        -- Currency
        currency,
        
        -- Metadata
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed
