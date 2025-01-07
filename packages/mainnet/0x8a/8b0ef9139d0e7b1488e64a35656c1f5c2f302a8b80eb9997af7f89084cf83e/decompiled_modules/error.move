module 0x8a8b0ef9139d0e7b1488e64a35656c1f5c2f302a8b80eb9997af7f89084cf83e::error {
    public fun address_cannot_be_zero() : u64 {
        105
    }

    public fun adl_all_or_nothing_constraint_can_not_be_held(arg0: u64) : u64 {
        803 + arg0
    }

    public fun can_not_be_greater_than_hundred_percent() : u64 {
        104
    }

    public fun cannot_overfill_order(arg0: u64) : u64 {
        arg0 + 44
    }

    public fun coin_does_not_have_enough_amount() : u64 {
        107
    }

    public fun fill_does_not_decrease_size(arg0: u64) : u64 {
        arg0 + 38
    }

    public fun fill_price_invalid(arg0: u64) : u64 {
        arg0 + 34
    }

    public fun funding_due_exceeds_margin(arg0: u64) : u64 {
        53 + arg0
    }

    public fun funding_rate_can_not_be_set_for_zeroth_window() : u64 {
        901
    }

    public fun funding_rate_for_window_already_set() : u64 {
        902
    }

    public fun initial_margin_must_be_greater_than_or_equal_to_mmr() : u64 {
        302
    }

    public fun invalid_deleveraging_operator() : u64 {
        113
    }

    public fun invalid_funding_rate_operator() : u64 {
        101
    }

    public fun invalid_guardian() : u64 {
        111
    }

    public fun invalid_leverage(arg0: u64) : u64 {
        arg0 + 40
    }

    public fun invalid_liquidator_leverage() : u64 {
        702
    }

    public fun invalid_price_oracle_operator() : u64 {
        100
    }

    public fun invalid_settlement_operator() : u64 {
        110
    }

    public fun leverage_can_not_be_set_to_zero() : u64 {
        504
    }

    public fun leverage_must_be_greater_than_zero(arg0: u64) : u64 {
        arg0 + 42
    }

    public fun liquidatee_above_mmr() : u64 {
        703
    }

    public fun liquidation_all_or_nothing_constraint_not_held() : u64 {
        701
    }

    public fun loss_exceeds_margin(arg0: u64) : u64 {
        arg0 + 46
    }

    public fun maintenance_margin_must_be_greater_than_zero() : u64 {
        300
    }

    public fun maintenance_margin_must_be_less_than_or_equal_to_imr() : u64 {
        301
    }

    public fun maker_is_not_underwater() : u64 {
        800
    }

    public fun maker_order_can_not_be_ioc() : u64 {
        106
    }

    public fun maker_taker_must_have_opposite_side_positions() : u64 {
        802
    }

    public fun margin_amount_must_be_greater_than_zero() : u64 {
        500
    }

    public fun margin_must_be_less_than_max_removable_margin() : u64 {
        503
    }

    public fun max_allowed_price_diff_cannot_be_zero() : u64 {
        103
    }

    public fun max_limit_qty_greater_than_min_qty() : u64 {
        15
    }

    public fun max_market_qty_less_than_min_qty() : u64 {
        16
    }

    public fun max_price_greater_than_min_price() : u64 {
        9
    }

    public fun min_price_greater_than_zero() : u64 {
        1
    }

    public fun min_price_less_than_max_price() : u64 {
        2
    }

    public fun min_qty_greater_than_zero() : u64 {
        18
    }

    public fun min_qty_less_than_max_qty() : u64 {
        17
    }

    public fun mr_less_than_imr_can_not_open_or_flip_position(arg0: u64) : u64 {
        400 + arg0
    }

    public fun mr_less_than_imr_mr_must_improve(arg0: u64) : u64 {
        402 + arg0
    }

    public fun mr_less_than_imr_position_can_only_reduce(arg0: u64) : u64 {
        404 + arg0
    }

    public fun mr_less_than_zero(arg0: u64) : u64 {
        406 + arg0
    }

    public fun mtb_long_greater_than_zero() : u64 {
        12
    }

    public fun mtb_short_greater_than_zero() : u64 {
        13
    }

    public fun mtb_short_less_than_hundred_percent() : u64 {
        14
    }

    public fun new_address_can_not_be_same_as_current_one() : u64 {
        900
    }

    public fun not_a_public_settlement_cap() : u64 {
        109
    }

    public fun not_enough_balance_in_margin_bank(arg0: u64) : u64 {
        600 + arg0
    }

    public fun oi_open_greater_than_max_allowed(arg0: u64) : u64 {
        arg0 + 25
    }

    public fun only_taker_of_trade_can_execute_trade_involving_non_orderbook_orders() : u64 {
        108
    }

    public fun operator_already_removed() : u64 {
        112
    }

    public fun operator_not_found() : u64 {
        8
    }

    public fun order_cannot_be_of_same_side() : u64 {
        48
    }

    public fun order_expired(arg0: u64) : u64 {
        arg0 + 32
    }

    public fun order_has_invalid_signature(arg0: u64) : u64 {
        arg0 + 30
    }

    public fun order_is_canceled(arg0: u64) : u64 {
        arg0 + 28
    }

    public fun out_of_max_allowed_price_diff_bounds() : u64 {
        102
    }

    public fun perpetual_has_been_already_de_listed() : u64 {
        60
    }

    public fun perpetual_is_delisted() : u64 {
        61
    }

    public fun perpetual_is_not_delisted() : u64 {
        62
    }

    public fun provided_coin_do_not_have_enough_amount() : u64 {
        606
    }

    public fun sender_does_not_have_permission_for_account(arg0: u64) : u64 {
        50 + arg0
    }

    public fun step_size_greater_than_zero() : u64 {
        10
    }

    public fun taker_is_under_underwater() : u64 {
        801
    }

    public fun taker_order_can_not_be_post_only() : u64 {
        49
    }

    public fun tick_size_greater_than_zero() : u64 {
        11
    }

    public fun trade_price_greater_than_max_price() : u64 {
        4
    }

    public fun trade_price_greater_than_mtb_long() : u64 {
        23
    }

    public fun trade_price_greater_than_mtb_short() : u64 {
        24
    }

    public fun trade_price_less_than_min_price() : u64 {
        3
    }

    public fun trade_price_tick_size_not_allowed() : u64 {
        5
    }

    public fun trade_qty_greater_than_limit_qty() : u64 {
        20
    }

    public fun trade_qty_greater_than_market_qty() : u64 {
        21
    }

    public fun trade_qty_less_than_min_qty() : u64 {
        19
    }

    public fun trade_qty_step_size_not_allowed() : u64 {
        22
    }

    public fun trading_is_stopped_on_perpetual() : u64 {
        63
    }

    public fun trading_not_started() : u64 {
        56
    }

    public fun user_already_has_position() : u64 {
        6
    }

    public fun user_has_no_bank_account() : u64 {
        605
    }

    public fun user_has_no_position_in_table(arg0: u64) : u64 {
        505 + arg0
    }

    public fun user_position_size_is_zero(arg0: u64) : u64 {
        510 + arg0
    }

    public fun withdrawal_is_not_allowed() : u64 {
        604
    }

    public fun wrong_price_identifier() : u64 {
        903
    }

    // decompiled from Move bytecode v6
}

