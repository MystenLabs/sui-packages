module 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors {
    public fun adl_bad_debt_position_not_closed() : u64 {
        38
    }

    public fun adl_counterparties_mismatch() : u64 {
        36
    }

    public fun adl_counterparty_insufficient() : u64 {
        37
    }

    public fun adl_weights_do_not_sum_to_one() : u64 {
        39
    }

    public fun bad_debt_above_threshold() : u64 {
        41
    }

    public fun bad_index_price() : u64 {
        2
    }

    public fun collateral_is_not_registered() : u64 {
        19
    }

    public fun deallocate_target_mr_too_low() : u64 {
        2008
    }

    public fun deposit_or_withdraw_amount_zero() : u64 {
        0
    }

    public fun destroy_not_empty() : u64 {
        3003
    }

    public fun empty_session() : u64 {
        17
    }

    public fun flag_requirements_violated() : u64 {
        3005
    }

    public fun initial_margin_requirements_violated() : u64 {
        2003
    }

    public fun insufficient_free_collateral() : u64 {
        2006
    }

    public fun insufficient_insurance_surplus() : u64 {
        1007
    }

    public fun integrator_vault_already_exists() : u64 {
        32
    }

    public fun integrator_vault_does_not_exist() : u64 {
        33
    }

    public fun invalid_account_cap() : u64 {
        13
    }

    public fun invalid_account_for_stop_order() : u64 {
        26
    }

    public fun invalid_base_price_feed_storage() : u64 {
        11
    }

    public fun invalid_cancel_order_ids() : u64 {
        7
    }

    public fun invalid_collateral_price_feed_storage() : u64 {
        21
    }

    public fun invalid_executor_for_stop_order() : u64 {
        27
    }

    public fun invalid_expiration_timestamp() : u64 {
        23
    }

    public fun invalid_force_cancel_ids() : u64 {
        5
    }

    public fun invalid_integrator_taker_fee() : u64 {
        14
    }

    public fun invalid_map_parameters() : u64 {
        3000
    }

    public fun invalid_market_parameters() : u64 {
        1000
    }

    public fun invalid_position_for_sltp() : u64 {
        2011
    }

    public fun invalid_position_imr() : u64 {
        2009
    }

    public fun invalid_price() : u64 {
        3
    }

    public fun invalid_proposal_delay() : u64 {
        1004
    }

    public fun invalid_share_policy() : u64 {
        42
    }

    public fun invalid_stop_order_type() : u64 {
        2010
    }

    public fun invalid_user_for_order() : u64 {
        3004
    }

    public fun key_already_exists() : u64 {
        3002
    }

    public fun key_not_exist() : u64 {
        3001
    }

    public fun liquidate_not_first_operation() : u64 {
        6
    }

    public fun liquidated_position_still_unhealthy() : u64 {
        2012
    }

    public fun map_too_small() : u64 {
        3007
    }

    public fun market_already_registered() : u64 {
        18
    }

    public fun market_is_closed() : u64 {
        1013
    }

    public fun market_is_not_closed() : u64 {
        1012
    }

    public fun market_is_not_paused() : u64 {
        1011
    }

    public fun market_is_not_registered() : u64 {
        20
    }

    public fun market_is_paused() : u64 {
        1010
    }

    public fun max_open_interest_surpassed() : u64 {
        28
    }

    public fun max_pending_orders_exceeded() : u64 {
        2000
    }

    public fun max_position_open_interest_percent_surpassed() : u64 {
        29
    }

    public fun negative_fees_accrued() : u64 {
        22
    }

    public fun no_fees_accrued() : u64 {
        1006
    }

    public fun no_open_interest_to_socialize_bad_debt() : u64 {
        40
    }

    public fun no_price_feed_for_market() : u64 {
        1008
    }

    public fun not_enough_collateral_to_allocate_for_session() : u64 {
        30
    }

    public fun not_enough_gas_for_stop_order() : u64 {
        24
    }

    public fun not_enough_liquidity() : u64 {
        3006
    }

    public fun order_usd_value_too_low() : u64 {
        4
    }

    public fun position_above_mmr() : u64 {
        2004
    }

    public fun position_above_tolerance() : u64 {
        2002
    }

    public fun position_already_exists() : u64 {
        2007
    }

    public fun position_bad_debt() : u64 {
        2005
    }

    public fun position_below_imr() : u64 {
        2001
    }

    public fun premature_proposal() : u64 {
        1003
    }

    public fun price_not_multiple_of_tick_size() : u64 {
        35
    }

    public fun proposal_already_exists() : u64 {
        1002
    }

    public fun proposal_already_matured() : u64 {
        1009
    }

    public fun proposal_does_not_exist() : u64 {
        1005
    }

    public fun reduce_only_violated() : u64 {
        15
    }

    public fun self_liquidation() : u64 {
        12
    }

    public fun size_not_multiple_of_lot_size() : u64 {
        34
    }

    public fun size_or_position_zero() : u64 {
        1
    }

    public fun stop_order_conditions_violated() : u64 {
        9
    }

    public fun stop_order_ticket_expired() : u64 {
        8
    }

    public fun too_many_assistants_per_account() : u64 {
        4000
    }

    public fun updating_funding_too_early() : u64 {
        1001
    }

    public fun wrong_account_id_for_allocation() : u64 {
        31
    }

    public fun wrong_order_details() : u64 {
        10
    }

    public fun wrong_version() : u64 {
        16
    }

    // decompiled from Move bytecode v6
}

