module 0x32b2c7b64185bde7b09bdce6e4b793d10181cd70f655aa69f66ac3039c12cd5c::constants {
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

