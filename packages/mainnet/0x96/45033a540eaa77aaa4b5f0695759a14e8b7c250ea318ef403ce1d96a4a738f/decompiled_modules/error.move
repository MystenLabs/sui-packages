module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error {
    public(friend) fun address_cannot_be_zero() : u64 {
        105
    }

    public(friend) fun adl_all_or_nothing_constraint_can_not_be_held(arg0: u64) : u64 {
        803 + arg0
    }

    public(friend) fun balance_conservation_violation() : u64 {
        99989
    }

    public(friend) fun bank_account_has_balance() : u64 {
        607
    }

    public(friend) fun bank_mismatch() : u64 {
        2022
    }

    public(friend) fun can_not_be_greater_than_hundred_percent() : u64 {
        104
    }

    public(friend) fun can_not_be_zero() : u64 {
        2015
    }

    public(friend) fun cannot_overfill_order(arg0: u64) : u64 {
        arg0 + 44
    }

    public(friend) fun coin_does_not_have_enough_amount() : u64 {
        107
    }

    public(friend) fun creator_shares_below_minimum() : u64 {
        2008
    }

    public(friend) fun deposit_amount_must_be_greater_than_zero() : u64 {
        1000
    }

    public(friend) fun deposit_paused() : u64 {
        2001
    }

    public(friend) fun exceeds_vault_max_cap() : u64 {
        2011
    }

    public(friend) fun exchange_already_paused() : u64 {
        100000
    }

    public(friend) fun exchange_already_resumed() : u64 {
        100001
    }

    public(friend) fun exchange_paused() : u64 {
        100002
    }

    public(friend) fun fill_does_not_decrease_size(arg0: u64) : u64 {
        arg0 + 38
    }

    public(friend) fun fill_price_invalid(arg0: u64) : u64 {
        arg0 + 34
    }

    public(friend) fun funding_due_exceeds_margin(arg0: u64) : u64 {
        53 + arg0
    }

    public(friend) fun funding_rate_can_not_be_set_for_zeroth_window() : u64 {
        901
    }

    public(friend) fun funding_rate_for_window_already_set() : u64 {
        902
    }

    public(friend) fun greater_than_max_allowed_funding() : u64 {
        904
    }

    public(friend) fun initial_margin_must_be_greater_than_or_equal_to_mmr() : u64 {
        302
    }

    public(friend) fun insufficient_shares() : u64 {
        2004
    }

    public(friend) fun insurance_active_account_can_not_open_new_position() : u64 {
        118
    }

    public(friend) fun insurance_fund_active_account_can_not_be_same_as_security_account() : u64 {
        114
    }

    public(friend) fun insurance_fund_transfer_amount_exceeds_limit() : u64 {
        116
    }

    public(friend) fun insurance_fund_transfer_amount_must_be_greater_than_zero() : u64 {
        117
    }

    public(friend) fun insurance_fund_transfer_interval_not_met() : u64 {
        115
    }

    public(friend) fun invalid_accounts_length() : u64 {
        109
    }

    public(friend) fun invalid_deleveraging_operator() : u64 {
        113
    }

    public(friend) fun invalid_deposit_amount() : u64 {
        2037
    }

    public(friend) fun invalid_funding_rate_operator() : u64 {
        101
    }

    public(friend) fun invalid_leverage(arg0: u64) : u64 {
        arg0 + 40
    }

    public(friend) fun invalid_liquidator_leverage() : u64 {
        702
    }

    public(friend) fun invalid_manager() : u64 {
        111
    }

    public(friend) fun invalid_pending_shares() : u64 {
        2039
    }

    public(friend) fun invalid_platform_operator() : u64 {
        2024
    }

    public(friend) fun invalid_price_oracle_operator() : u64 {
        100
    }

    public(friend) fun invalid_protocol_version() : u64 {
        3000
    }

    public(friend) fun invalid_ratio() : u64 {
        2028
    }

    public(friend) fun invalid_settlement_operator() : u64 {
        110
    }

    public(friend) fun invalid_status() : u64 {
        2026
    }

    public(friend) fun invalid_trader_address() : u64 {
        2025
    }

    public(friend) fun leverage_can_not_be_set_to_zero() : u64 {
        504
    }

    public(friend) fun leverage_must_be_greater_than_zero(arg0: u64) : u64 {
        arg0 + 42
    }

    public(friend) fun liquidatee_above_mmr() : u64 {
        703
    }

    public(friend) fun liquidation_all_or_nothing_constraint_not_held() : u64 {
        701
    }

    public(friend) fun loss_exceeds_margin(arg0: u64) : u64 {
        arg0 + 46
    }

    public(friend) fun maintenance_margin_must_be_greater_than_zero() : u64 {
        300
    }

    public(friend) fun maintenance_margin_must_be_less_than_or_equal_to_imr() : u64 {
        301
    }

    public(friend) fun maker_is_not_underwater() : u64 {
        800
    }

    public(friend) fun maker_order_can_not_be_ioc() : u64 {
        106
    }

    public(friend) fun maker_taker_must_have_opposite_side_positions() : u64 {
        802
    }

    public(friend) fun margin_amount_must_be_greater_than_zero() : u64 {
        500
    }

    public(friend) fun margin_must_be_less_than_max_removable_margin() : u64 {
        503
    }

    public(friend) fun max_allowed_price_diff_cannot_be_zero() : u64 {
        103
    }

    public(friend) fun max_limit_qty_greater_than_min_qty() : u64 {
        15
    }

    public(friend) fun max_market_qty_less_than_min_qty() : u64 {
        16
    }

    public(friend) fun max_price_greater_than_min_price() : u64 {
        9
    }

    public(friend) fun method_deprecated() : u64 {
        999
    }

    public(friend) fun min_price_greater_than_zero() : u64 {
        1
    }

    public(friend) fun min_price_less_than_max_price() : u64 {
        2
    }

    public(friend) fun min_qty_greater_than_zero() : u64 {
        18
    }

    public(friend) fun min_qty_less_than_max_qty() : u64 {
        17
    }

    public(friend) fun mr_less_than_imr_can_not_open_or_flip_position(arg0: u64) : u64 {
        400 + arg0
    }

    public(friend) fun mr_less_than_imr_mr_must_improve(arg0: u64) : u64 {
        402 + arg0
    }

    public(friend) fun mr_less_than_imr_position_can_only_reduce(arg0: u64) : u64 {
        404 + arg0
    }

    public(friend) fun mr_less_than_zero(arg0: u64) : u64 {
        406 + arg0
    }

    public(friend) fun mtb_long_greater_than_zero() : u64 {
        12
    }

    public(friend) fun mtb_short_greater_than_zero() : u64 {
        13
    }

    public(friend) fun mtb_short_less_than_hundred_percent() : u64 {
        14
    }

    public(friend) fun new_address_can_not_be_same_as_current_one() : u64 {
        900
    }

    public(friend) fun not_enough_balance_in_bank(arg0: u64) : u64 {
        600 + arg0
    }

    public(friend) fun object_version_mismatch() : u64 {
        905
    }

    public(friend) fun oi_open_greater_than_max_allowed(arg0: u64) : u64 {
        arg0 + 25
    }

    public(friend) fun only_taker_of_trade_can_execute_trade_involving_non_orderbook_orders() : u64 {
        108
    }

    public(friend) fun operator_already_removed() : u64 {
        112
    }

    public(friend) fun operator_not_found() : u64 {
        8
    }

    public(friend) fun order_cannot_be_of_same_side() : u64 {
        48
    }

    public(friend) fun order_expired(arg0: u64) : u64 {
        arg0 + 32
    }

    public(friend) fun order_has_invalid_signature(arg0: u64) : u64 {
        arg0 + 30
    }

    public(friend) fun order_is_canceled(arg0: u64) : u64 {
        arg0 + 28
    }

    public(friend) fun out_of_max_allowed_price_diff_bounds() : u64 {
        102
    }

    public(friend) fun perpetual_has_been_already_de_listed() : u64 {
        60
    }

    public(friend) fun perpetual_is_delisted() : u64 {
        61
    }

    public(friend) fun perpetual_is_not_delisted() : u64 {
        62
    }

    public(friend) fun perpetual_not_found() : u64 {
        2030
    }

    public(friend) fun perpetual_position_value_already_computed() : u64 {
        2029
    }

    public(friend) fun provided_coin_do_not_have_enough_amount() : u64 {
        606
    }

    public(friend) fun self_liquidation_not_allowed() : u64 {
        704
    }

    public(friend) fun sender_does_not_have_permission_for_account(arg0: u64) : u64 {
        50 + arg0
    }

    public(friend) fun step_size_greater_than_zero() : u64 {
        10
    }

    public(friend) fun taker_is_under_underwater() : u64 {
        801
    }

    public(friend) fun taker_order_can_not_be_post_only() : u64 {
        49
    }

    public(friend) fun tick_size_greater_than_zero() : u64 {
        11
    }

    public(friend) fun trade_price_greater_than_max_price() : u64 {
        4
    }

    public(friend) fun trade_price_greater_than_mtb_long() : u64 {
        23
    }

    public(friend) fun trade_price_greater_than_mtb_short() : u64 {
        24
    }

    public(friend) fun trade_price_less_than_min_price() : u64 {
        3
    }

    public(friend) fun trade_price_tick_size_not_allowed() : u64 {
        5
    }

    public(friend) fun trade_qty_greater_than_limit_qty() : u64 {
        20
    }

    public(friend) fun trade_qty_greater_than_market_qty() : u64 {
        21
    }

    public(friend) fun trade_qty_less_than_min_qty() : u64 {
        19
    }

    public(friend) fun trade_qty_step_size_not_allowed() : u64 {
        22
    }

    public(friend) fun trading_is_stopped_on_perpetual() : u64 {
        63
    }

    public(friend) fun trading_not_started() : u64 {
        56
    }

    public(friend) fun transaction_replay() : u64 {
        906
    }

    public(friend) fun unauthorized() : u64 {
        920
    }

    public(friend) fun unreachable() : u64 {
        99999
    }

    public(friend) fun user_already_has_position() : u64 {
        6
    }

    public(friend) fun user_has_no_bank_account() : u64 {
        605
    }

    public(friend) fun user_has_no_position_in_table(arg0: u64) : u64 {
        505 + arg0
    }

    public(friend) fun user_position_size_is_zero(arg0: u64) : u64 {
        510 + arg0
    }

    public(friend) fun vault_bank_balance_mismatch() : u64 {
        2045
    }

    public(friend) fun vault_closed() : u64 {
        2009
    }

    public(friend) fun vault_creator_locked_shares_cannot_withdraw() : u64 {
        2044
    }

    public(friend) fun vault_creator_locked_shares_insufficient() : u64 {
        2043
    }

    public(friend) fun vault_creator_must_deposit_first() : u64 {
        2042
    }

    public(friend) fun vault_creator_not_allowed_to_request_withdraw() : u64 {
        2034
    }

    public(friend) fun vault_direct_withdraw_not_enabled() : u64 {
        2002
    }

    public(friend) fun vault_has_pending_withdrawals() : u64 {
        2003
    }

    public(friend) fun vault_has_position() : u64 {
        2014
    }

    public(friend) fun vault_insufficient_balance() : u64 {
        2027
    }

    public(friend) fun vault_invalid_protocol_status() : u64 {
        2013
    }

    public(friend) fun vault_lock_period_too_long() : u64 {
        2005
    }

    public(friend) fun vault_max_depositors_reached() : u64 {
        2017
    }

    public(friend) fun vault_min_deposit_amount_too_low() : u64 {
        2036
    }

    public(friend) fun vault_mismatch() : u64 {
        2012
    }

    public(friend) fun vault_name_already_exists() : u64 {
        2023
    }

    public(friend) fun vault_nav_and_shares_should_be_zero() : u64 {
        2040
    }

    public(friend) fun vault_nav_not_filled() : u64 {
        2035
    }

    public(friend) fun vault_not_closed() : u64 {
        2010
    }

    public(friend) fun vault_user_not_exist() : u64 {
        2033
    }

    public(friend) fun vault_withdrawal_filling_gas_fee_too_high() : u64 {
        2006
    }

    public(friend) fun vault_withdrawal_locked() : u64 {
        2038
    }

    public(friend) fun vault_withdrawal_shares_too_low() : u64 {
        2041
    }

    public(friend) fun vector_too_long() : u64 {
        907
    }

    public(friend) fun withdraw_amount_must_be_greater_than_zero() : u64 {
        1001
    }

    public(friend) fun withdrawal_is_not_allowed() : u64 {
        604
    }

    public(friend) fun wrong_price_identifier() : u64 {
        903
    }

    // decompiled from Move bytecode v6
}

