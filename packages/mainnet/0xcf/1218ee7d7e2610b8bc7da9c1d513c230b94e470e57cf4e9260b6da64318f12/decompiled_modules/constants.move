module 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants {
    public fun default_dao_creation_fee() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::default_dao_creation_fee()
    }

    public fun default_launchpad_creation_fee() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::default_launchpad_creation_fee()
    }

    public fun default_proposal_creation_fee() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::default_proposal_creation_fee()
    }

    public fun default_proposal_fee_per_outcome() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::default_proposal_fee_per_outcome()
    }

    public fun launchpad_bid_fee_per_contribution() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::launchpad_bid_fee_per_contribution()
    }

    public fun launchpad_min_duration_ms() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::launchpad_min_duration_ms()
    }

    public fun min_execution_window_ms() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::min_execution_window_ms()
    }

    public fun min_proposal_intent_expiry_ms() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::min_proposal_intent_expiry_ms()
    }

    public fun min_review_period_ms() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::min_review_period_ms()
    }

    public fun min_trading_period_ms() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::min_trading_period_ms()
    }

    public fun protocol_min_liquidity_amount() : u64 {
        0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::protocol_min_liquidity_amount()
    }

    public fun dao_init_intent_expiry_ms() : u64 {
        2592000000
    }

    public fun dao_init_max_actions() : u64 {
        protocol_max_actions_per_outcome()
    }

    public fun default_conditional_amm_fee_bps() : u64 {
        25
    }

    public fun default_conditional_liquidity_percent() : u64 {
        80
    }

    public fun default_max_actions_per_outcome() : u64 {
        10
    }

    public fun default_max_outcomes() : u64 {
        2
    }

    public fun default_proposal_intent_expiry_ms() : u64 {
        2592000000
    }

    public fun default_twap_max_movement_ppm() : u64 {
        10000
    }

    public fun default_twap_threshold() : u64 {
        100
    }

    public fun execution_window_ms() : u64 {
        let v0 = 1800000;
        let v1 = 0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants::min_execution_window_ms();
        if (v0 > v1) {
            v0
        } else {
            v1
        }
    }

    public fun factory_max_init_actions() : u64 {
        dao_init_max_actions()
    }

    public fun fee_precision_scale() : u128 {
        100000
    }

    public fun fifteen_minutes_ms() : u64 {
        900000
    }

    public fun launchpad_max_affiliate_id_length() : u64 {
        64
    }

    public fun launchpad_max_batch_size() : u64 {
        100
    }

    public fun launchpad_max_description_length() : u64 {
        1000
    }

    public fun launchpad_max_duration_ms() : u64 {
        7776000000
    }

    public fun launchpad_max_init_actions() : u64 {
        dao_init_max_actions()
    }

    public fun launchpad_max_metadata_pairs() : u64 {
        20
    }

    public fun launchpad_max_reservations() : u64 {
        50
    }

    public fun launchpad_max_start_delay_ms() : u64 {
        2592000000
    }

    public fun launchpad_max_unique_caps() : u64 {
        128
    }

    public fun maintenance_threshold() : u64 {
        10
    }

    public fun max_amm_fee_bps() : u64 {
        500
    }

    public fun max_beneficiaries() : u64 {
        100
    }

    public fun max_cleanup_per_call() : u64 {
        20
    }

    public fun max_conditional_liquidity_percent() : u64 {
        99
    }

    public fun max_execution_window_ms() : u64 {
        7200000
    }

    public fun max_fee_multiplier() : u64 {
        10
    }

    public fun max_launch_fee_bps() : u64 {
        9900
    }

    public fun max_oracle_tiers() : u64 {
        20
    }

    public fun max_proposal_creation_fee() : u64 {
        10000000000
    }

    public fun max_proposal_fee_per_outcome() : u64 {
        10000000000
    }

    public fun max_protective_asks_per_dao() : u64 {
        10
    }

    public fun max_protective_bid_fee_bps() : u64 {
        2000
    }

    public fun max_protective_bids_per_dao() : u64 {
        1
    }

    public fun max_quota_entries() : u64 {
        50
    }

    public fun max_recipients_per_tier() : u64 {
        100
    }

    public fun max_sponsored_threshold() : u128 {
        10000
    }

    public fun max_trading_duration_ms() : u64 {
        2592000000
    }

    public fun max_twap_checkpoints() : u64 {
        20
    }

    public fun min_conditional_liquidity_percent() : u64 {
        1
    }

    public fun min_outcomes() : u64 {
        2
    }

    public fun minimum_liquidity() : u64 {
        1000
    }

    public fun ninety_days_ms() : u64 {
        7776000000
    }

    public fun one_day_ms() : u64 {
        86400000
    }

    public fun one_week_ms() : u64 {
        604800000
    }

    public fun oracle_conditional_threshold_bps() : u64 {
        5000
    }

    public fun ppm_denominator() : u64 {
        1000000
    }

    public fun price_precision_scale() : u64 {
        1000000000000
    }

    public fun price_scale() : u128 {
        1000000000000
    }

    public fun protocol_fee_bps() : u64 {
        50
    }

    public fun protocol_max_actions_per_outcome() : u64 {
        50
    }

    public fun protocol_max_outcomes() : u64 {
        50
    }

    public fun six_months_ms() : u64 {
        15552000000
    }

    public fun ten_years_ms() : u64 {
        315360000000
    }

    public fun thirty_days_ms() : u64 {
        2592000000
    }

    public fun thirty_minutes_ms() : u64 {
        1800000
    }

    public fun three_days_ms() : u64 {
        259200000
    }

    public fun total_fee_bps() : u64 {
        10000
    }

    public fun twap_price_cap_window() : u64 {
        60000
    }

    public fun twap_threshold_base() : u128 {
        100000
    }

    public fun twelve_hours_ms() : u64 {
        43200000
    }

    // decompiled from Move bytecode v6
}

