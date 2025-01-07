module 0x2eeea63815b558faee960ea9e9cf53100bddd07fb1f1ca0fd627b564083dd7f4::errors {
    public fun deposit_amount_is_too_low() : u64 {
        16
    }

    public fun fee_is_too_high() : u64 {
        1
    }

    public fun insufficient_liquidity() : u64 {
        14
    }

    public fun invalid_active_account() : u64 {
        20
    }

    public fun invalid_invariant() : u64 {
        10
    }

    public fun invalid_quote_token() : u64 {
        18
    }

    public fun invalid_rent_per_second() : u64 {
        17
    }

    public fun lp_stake_time_not_passed() : u64 {
        22
    }

    public fun meme_and_ticket_coins_must_have_6_decimals() : u64 {
        7
    }

    public fun no_funds_to_withdraw() : u64 {
        100
    }

    public fun no_zero_coin() : u64 {
        9
    }

    public fun not_enough_funds_to_lend() : u64 {
        0
    }

    public fun pool_already_deployed() : u64 {
        5
    }

    public fun pool_is_locked() : u64 {
        11
    }

    public fun provide_both_coins() : u64 {
        3
    }

    public fun select_different_coins() : u64 {
        2
    }

    public fun should_have_0_total_supply() : u64 {
        21
    }

    public fun slippage() : u64 {
        8
    }

    public fun wrong_module_name() : u64 {
        13
    }

    public fun wrong_pool() : u64 {
        15
    }

    // decompiled from Move bytecode v6
}

