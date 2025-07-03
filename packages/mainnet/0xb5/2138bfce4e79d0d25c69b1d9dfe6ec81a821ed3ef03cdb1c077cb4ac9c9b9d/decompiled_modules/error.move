module 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::error {
    public(friend) fun active_trading_symbol() : u64 {
        abort 4
    }

    public(friend) fun add_size_not_allowed() : u64 {
        abort 14
    }

    public(friend) fun auction_not_yet_ended() : u64 {
        abort 29
    }

    public(friend) fun authority_already_existed() : u64 {
        abort 0
    }

    public(friend) fun authority_doest_not_exist() : u64 {
        abort 1
    }

    public(friend) fun authority_empty() : u64 {
        abort 2
    }

    public(friend) fun balance_not_enough_for_paying_fee() : u64 {
        abort 27
    }

    public(friend) fun base_token_mismatched() : u64 {
        abort 15
    }

    public(friend) fun bid_receipt_has_been_expired() : u64 {
        abort 9
    }

    public(friend) fun bid_receipt_not_expired() : u64 {
        abort 10
    }

    public(friend) fun bid_receipt_not_itm() : u64 {
        abort 11
    }

    public(friend) fun bid_token_mismatched() : u64 {
        abort 30
    }

    public(friend) fun collateral_token_type_mismatched() : u64 {
        abort 8
    }

    public(friend) fun deactivating_shares_already_existed() : u64 {
        abort 16
    }

    public(friend) fun deposit_amount_insufficient() : u64 {
        abort 6
    }

    public(friend) fun deposit_token_mismatched() : u64 {
        abort 3
    }

    public(friend) fun exceed_max_leverage() : u64 {
        abort 7
    }

    public(friend) fun exceed_max_open_interest() : u64 {
        abort 31
    }

    public(friend) fun exceed_rebalance_cost_threshold() : u64 {
        abort 102
    }

    public(friend) fun friction_too_large() : u64 {
        abort 14
    }

    public(friend) fun insufficient_amount_for_mint_fee() : u64 {
        abort 8
    }

    public(friend) fun invalid_bid_receipts_input() : u64 {
        abort 2
    }

    public(friend) fun invalid_boost_bp_array_length() : u64 {
        abort 0
    }

    public(friend) fun invalid_config_range() : u64 {
        abort 19
    }

    public(friend) fun invalid_order_side() : u64 {
        abort 12
    }

    public(friend) fun invalid_order_size() : u64 {
        abort 13
    }

    public(friend) fun invalid_token_type() : u64 {
        abort 15
    }

    public(friend) fun invalid_trading_fee_config() : u64 {
        abort 25
    }

    public(friend) fun invalid_version() : u64 {
        abort 3
    }

    public(friend) fun linked_order_id_not_existed() : u64 {
        abort 4
    }

    public(friend) fun liquidity_not_enough() : u64 {
        abort 11
    }

    public(friend) fun liquidity_token_existed() : u64 {
        abort 18
    }

    public(friend) fun liquidity_token_not_existed() : u64 {
        abort 5
    }

    public(friend) fun lp_pool_reserve_not_enough() : u64 {
        abort 23
    }

    public(friend) fun lp_token_type_mismatched() : u64 {
        abort 4
    }

    public(friend) fun markets_inactive() : u64 {
        abort 2
    }

    public(friend) fun not_option_collateral_order() : u64 {
        abort 6
    }

    public(friend) fun not_option_collateral_position() : u64 {
        abort 7
    }

    public(friend) fun not_reduce_only_execution() : u64 {
        abort 0
    }

    public(friend) fun not_token_collateral_position() : u64 {
        abort 8
    }

    public(friend) fun option_collateral_not_enough() : u64 {
        abort 18
    }

    public(friend) fun option_collateral_order_not_filled() : u64 {
        abort 21
    }

    public(friend) fun oracle_mismatched() : u64 {
        abort 7
    }

    public(friend) fun order_not_filled_immediately() : u64 {
        abort 22
    }

    public(friend) fun order_not_found() : u64 {
        abort 5
    }

    public(friend) fun order_or_position_size_not_zero() : u64 {
        abort 26
    }

    public(friend) fun perp_position_losses() : u64 {
        abort 24
    }

    public(friend) fun pool_already_active() : u64 {
        abort 1
    }

    public(friend) fun pool_inactive() : u64 {
        abort 0
    }

    public(friend) fun pool_index_mismatched() : u64 {
        abort 20
    }

    public(friend) fun portfolio_index_mismatched() : u64 {
        abort 5
    }

    public(friend) fun position_id_needed_with_reduce_only_order() : u64 {
        abort 28
    }

    public(friend) fun process_should_remove_order() : u64 {
        abort 901
    }

    public(friend) fun process_should_remove_position() : u64 {
        abort 900
    }

    public(friend) fun process_should_repay_liquidity() : u64 {
        abort 903
    }

    public(friend) fun process_should_swap() : u64 {
        abort 902
    }

    public(friend) fun reach_max_capacity() : u64 {
        abort 12
    }

    public(friend) fun reach_max_single_order_reserve_usage() : u64 {
        abort 20
    }

    public(friend) fun reach_slippage_threshold() : u64 {
        abort 13
    }

    public(friend) fun rebalance_process_field_mismatched() : u64 {
        abort 101
    }

    public(friend) fun remaining_collateral_not_enough() : u64 {
        abort 19
    }

    public(friend) fun token_collateral_not_enough() : u64 {
        abort 17
    }

    public(friend) fun token_pool_already_active() : u64 {
        abort 3
    }

    public(friend) fun token_pool_inactive() : u64 {
        abort 2
    }

    public(friend) fun too_many_linked_orders() : u64 {
        abort 9
    }

    public(friend) fun trading_symbol_existed() : u64 {
        abort 0
    }

    public(friend) fun trading_symbol_inactive() : u64 {
        abort 3
    }

    public(friend) fun trading_symbol_not_existed() : u64 {
        abort 1
    }

    public(friend) fun tvl_not_yet_updated() : u64 {
        abort 10
    }

    public(friend) fun unauthorized() : u64 {
        abort 4
    }

    public(friend) fun unsupported_order_type_tag() : u64 {
        abort 6
    }

    public(friend) fun unsupported_process_status_code() : u64 {
        abort 904
    }

    public(friend) fun user_deactivating_shares_not_existed() : u64 {
        abort 17
    }

    public(friend) fun user_mismatched() : u64 {
        abort 16
    }

    public(friend) fun wrong_collateral_type() : u64 {
        abort 1
    }

    public(friend) fun zero_price() : u64 {
        abort 0
    }

    public(friend) fun zero_total_supply() : u64 {
        abort 9
    }

    // decompiled from Move bytecode v6
}

