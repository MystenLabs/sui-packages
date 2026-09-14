module 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors {
    public fun already_claimed() : u64 {
        502
    }

    public fun currency_mismatch() : u64 {
        206
    }

    public fun deadline_expired() : u64 {
        302
    }

    public fun dev_buy_too_large() : u64 {
        209
    }

    public fun fee_route_locked() : u64 {
        211
    }

    public fun fee_too_high() : u64 {
        101
    }

    public fun insufficient_payment() : u64 {
        106
    }

    public fun insufficient_rewards() : u64 {
        500
    }

    public fun invalid_allocation() : u64 {
        201
    }

    public fun invalid_config() : u64 {
        102
    }

    public fun invalid_fee_route() : u64 {
        210
    }

    public fun invalid_market_cap() : u64 {
        202
    }

    public fun invalid_proof() : u64 {
        503
    }

    public fun invalid_supply() : u64 {
        200
    }

    public fun invalid_supply_policy() : u64 {
        204
    }

    public fun invalid_vesting() : u64 {
        205
    }

    public fun invalid_window() : u64 {
        501
    }

    public fun not_beneficiary() : u64 {
        401
    }

    public fun nothing_to_claim() : u64 {
        400
    }

    public fun protocol_paused() : u64 {
        104
    }

    public fun quote_not_allowed() : u64 {
        105
    }

    public fun round_closed() : u64 {
        504
    }

    public fun round_not_ended() : u64 {
        505
    }

    public fun slippage_exceeded() : u64 {
        301
    }

    public fun tick_spacing_not_allowed() : u64 {
        207
    }

    public fun treasury_not_fresh() : u64 {
        203
    }

    public fun unauthorized() : u64 {
        100
    }

    public fun wrong_launch() : u64 {
        402
    }

    public fun wrong_pool() : u64 {
        208
    }

    public fun wrong_version() : u64 {
        103
    }

    public fun zero_amount() : u64 {
        300
    }

    // decompiled from Move bytecode v7
}

