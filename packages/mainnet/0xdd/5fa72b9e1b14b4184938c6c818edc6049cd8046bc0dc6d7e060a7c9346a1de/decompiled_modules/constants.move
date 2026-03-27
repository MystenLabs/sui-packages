module 0xdd5fa72b9e1b14b4184938c6c818edc6049cd8046bc0dc6d7e060a7c9346a1de::constants {
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

