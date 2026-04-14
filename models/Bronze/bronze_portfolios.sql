{{
    config(
        materialized='view',
        tags=['Bronze', 'portfolios']
    )
}}

-- Clean and type portfolio master data from raw source
with source as (
    select * from {{ source('raw_data', 'PORTFOLIOS') }}
),

renamed as (
    select
        -- Primary key
        portfolio_id,
        
        -- Descriptive
        portfolio_name,
        portfolio_type,
        strategy,
        portfolio_manager,
        
        -- Configuration
        base_currency,
        inception_date::date as inception_date,
        status,
        benchmark_index,
        risk_profile,
        
        -- Metadata
        current_timestamp() as dbt_loaded_at
        
    from source
)

select * from renamed