module 0xad61a942de9a435d3c862b91659cbfd9d66d2eb67820066ee415bcc0ffac5bc5::error {
    public fun factory_contract_exists() : u64 {
        517
    }

    public fun factory_invalid_expiry() : u64 {
        516
    }

    public fun factory_yc_expired() : u64 {
        519
    }

    public fun factory_yc_not_expired() : u64 {
        520
    }

    public fun factory_zero_expiry_divisor() : u64 {
        515
    }

    public fun interest_fee_rate_too_high() : u64 {
        513
    }

    public fun invalid_argument(arg0: u64) : u64 {
        arg0
    }

    public fun market_burn_pt_amount_is_zero() : u64 {
        792
    }

    public fun market_burn_sy_amount_is_zero() : u64 {
        791
    }

    public fun market_exchange_rate_below_one() : u64 {
        790
    }

    public fun market_exchange_rate_can_not_be_one() : u64 {
        789
    }

    public fun market_exchange_rate_negative() : u64 {
        786
    }

    public fun market_exists() : u64 {
        774
    }

    public fun market_expired() : u64 {
        784
    }

    public fun market_factory_reserve_fee_too_high() : u64 {
        773
    }

    public fun market_initial_anchor_too_low() : u64 {
        772
    }

    public fun market_insufficient_pt_for_swap() : u64 {
        793
    }

    public fun market_insufficient_sy_for_swap() : u64 {
        801
    }

    public fun market_liquidity_too_low() : u64 {
        785
    }

    public fun market_ln_fee_rate_too_high() : u64 {
        771
    }

    public fun market_ln_implied_rate_is_zero() : u64 {
        790
    }

    public fun market_proportion_can_not_be_one() : u64 {
        788
    }

    public fun market_proportion_too_high() : u64 {
        787
    }

    public fun market_pt_amount_is_zero() : u64 {
        776
    }

    public fun market_pt_expired() : u64 {
        770
    }

    public fun market_rate_scalar_negative() : u64 {
        800
    }

    public fun market_scalar_root_below_zero() : u64 {
        769
    }

    public fun market_scalar_root_is_zero() : u64 {
        775
    }

    public fun market_sy_amount_is_zero() : u64 {
        777
    }

    public fun mismatch_yt_pt_tokens() : u64 {
        518
    }

    public fun reward_fee_rate_too_high() : u64 {
        514
    }

    public fun sy_insufficient_amountOut() : u64 {
        260
    }

    public fun sy_insufficient_sharesOut() : u64 {
        258
    }

    public fun sy_zero_deposit() : u64 {
        257
    }

    public fun sy_zero_redeem() : u64 {
        259
    }

    // decompiled from Move bytecode v6
}

