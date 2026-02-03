module 0x7652401d237449eaf43391ac9e089df3012bdf5978caf485a6da3b983c2c8be0::constants {
    public fun abort_on_unhealthy_liquidation() : bool {
        true
    }

    public fun ask() : bool {
        true
    }

    public fun b9_scaling() : u256 {
        1000000000
    }

    public fun bid() : bool {
        false
    }

    public fun fill_or_kill() : u64 {
        1
    }

    public fun force_equal_version() : bool {
        true
    }

    public fun immediate_or_cancel() : u64 {
        3
    }

    public fun insurance_open_interest_fraction() : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(500, 10000)
    }

    public fun low_min_order_usd_value() : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(50, 100)
    }

    public fun max_abs_maker_fee() : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(500, 10000)
    }

    public fun max_abs_taker_fee() : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(500, 10000)
    }

    public fun max_book_index_spread_percent() : u64 {
        5
    }

    public fun max_force_cancel_fee() : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(500, 10000)
    }

    public fun max_funding_period_ms() : u64 {
        129600000
    }

    public fun max_insurance_fund_fee() : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(500, 10000)
    }

    public fun max_liquidation_fee() : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(500, 10000)
    }

    public fun max_proposal_delay_ms() : u64 {
        259200000
    }

    public fun min_funding_frequency_ms() : u64 {
        60000
    }

    public fun min_funding_period_ms() : u64 {
        21600000
    }

    public fun min_gas_price_twap_period_ms() : u64 {
        10000
    }

    public fun min_oracle_tolerance() : u64 {
        500
    }

    public fun min_premium_twap_frequency_ms() : u64 {
        1000
    }

    public fun min_premium_twap_period_ms() : u64 {
        60000
    }

    public fun min_proposal_delay_ms() : u64 {
        86400000
    }

    public fun min_spread_twap_frequency_ms() : u64 {
        1000
    }

    public fun min_spread_twap_period_ms() : u64 {
        60000
    }

    public fun null_fee() : u256 {
        1000000000000000000
    }

    public fun one_b9() : u64 {
        1000000000
    }

    public fun one_fixed() : u256 {
        1000000000000000000
    }

    public fun order_types() : u64 {
        4
    }

    public fun post_only() : u64 {
        2
    }

    public fun sltp() : u64 {
        0
    }

    public fun standalone() : u64 {
        1
    }

    public fun standard_order() : u64 {
        0
    }

    public fun stop_order_types() : u64 {
        2
    }

    public fun up_max_pending_orders() : u64 {
        100
    }

    public fun up_min_order_usd_value() : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64fraction(100000, 100)
    }

    public fun version() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

