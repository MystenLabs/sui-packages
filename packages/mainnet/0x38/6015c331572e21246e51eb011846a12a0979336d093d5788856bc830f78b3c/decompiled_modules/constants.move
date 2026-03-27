module 0x386015c331572e21246e51eb011846a12a0979336d093d5788856bc830f78b3c::constants {
    public fun default_dao_creation_fee() : u64 {
        10000000000
    }

    public fun default_launchpad_creation_fee() : u64 {
        10000000000
    }

    public fun default_proposal_creation_fee() : u64 {
        2000000000
    }

    public fun default_proposal_fee_per_outcome() : u64 {
        1000000000
    }

    public fun launchpad_bid_fee_per_contribution() : u64 {
        100000000
    }

    public fun launchpad_min_duration_ms() : u64 {
        60000
    }

    public fun min_execution_window_ms() : u64 {
        3600000
    }

    public fun min_proposal_intent_expiry_ms() : u64 {
        3600000
    }

    public fun min_review_period_ms() : u64 {
        3600000
    }

    public fun min_trading_period_ms() : u64 {
        3600000
    }

    public fun multisig_creation_fee() : u64 {
        10000000000
    }

    public fun protocol_min_liquidity_amount() : u64 {
        100000
    }

    // decompiled from Move bytecode v6
}

