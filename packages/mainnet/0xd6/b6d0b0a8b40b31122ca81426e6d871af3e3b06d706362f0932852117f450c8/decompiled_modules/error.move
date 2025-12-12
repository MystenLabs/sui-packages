module 0xb9edebb239552dea0f88dc74a92ec79dbfc0f43c249d784bb5931e1f9b198359::error {
    public fun amount_in_above_max_limit() : u64 {
        abort 1
    }

    public fun assets_and_prices_size_not_match() : u64 {
        abort 37
    }

    public fun aum_done_err() : u64 {
        abort 20
    }

    public fun buffer_assets_not_empty() : u64 {
        abort 53
    }

    public fun clmm_pool_not_match() : u64 {
        abort 23
    }

    public fun fee_claim_err() : u64 {
        abort 18
    }

    public fun growth_overflow() : u64 {
        abort 58
    }

    public fun hard_cap_reached() : u64 {
        abort 5
    }

    public fun incorrect_repay_amount() : u64 {
        abort 63
    }

    public fun incorrect_repay_port_id() : u64 {
        abort 6
    }

    public fun incorrect_repay_type() : u64 {
        abort 7
    }

    public fun invalid_aggregator_price() : u64 {
        abort 68
    }

    public fun invalid_last_aum() : u64 {
        abort 40
    }

    public fun invalid_liquidity() : u64 {
        abort 39
    }

    public fun invalid_liquidity_range() : u64 {
        abort 16
    }

    public fun invalid_oracle_price() : u64 {
        abort 29
    }

    public fun invalid_price_feed_id() : u64 {
        abort 28
    }

    public fun invalid_protocol_fee_rate() : u64 {
        abort 13
    }

    public fun invalid_swap_slippage() : u64 {
        abort 62
    }

    public fun liquidity_range_not_change() : u64 {
        abort 38
    }

    public fun mining_claim_err() : u64 {
        abort 19
    }

    public fun no_available_osail_reward() : u64 {
        abort 55
    }

    public fun no_operation_manager_permission() : u64 {
        abort 9
    }

    public fun no_oracle_manager_permission() : u64 {
        abort 11
    }

    public fun no_pool_manager_permission() : u64 {
        abort 10
    }

    public fun no_port_creator_permission() : u64 {
        abort 64
    }

    public fun no_protocol_fee_claim_permission() : u64 {
        abort 8
    }

    public fun not_claimed_previous_osail_reward() : u64 {
        abort 56
    }

    public fun not_owner() : u64 {
        abort 63
    }

    public fun not_updated_osail_growth_time() : u64 {
        abort 42
    }

    public fun not_updated_reward_growth_time() : u64 {
        abort 41
    }

    public fun operation_not_allowed() : u64 {
        abort 25
    }

    public fun oracle_info_exists() : u64 {
        abort 26
    }

    public fun oracle_info_not_exists() : u64 {
        abort 27
    }

    public fun osail_growth_not_match() : u64 {
        abort 44
    }

    public fun osail_reward_empty() : u64 {
        abort 50
    }

    public fun osail_reward_not_claimed() : u64 {
        abort 57
    }

    public fun osail_reward_not_enough() : u64 {
        abort 51
    }

    public fun osail_withdraw_cert_not_match() : u64 {
        abort 49
    }

    public fun osail_withdraw_cert_pool_id_not_match() : u64 {
        abort 48
    }

    public fun package_version_deprecate() : u64 {
        abort 12
    }

    public fun pool_not_need_rebalance() : u64 {
        abort 21
    }

    public fun port_entry_not_match() : u64 {
        abort 36
    }

    public fun port_entry_port_id_not_match() : u64 {
        abort 24
    }

    public fun port_entry_time_not_match() : u64 {
        abort 52
    }

    public fun port_entry_volume_empty() : u64 {
        abort 46
    }

    public fun port_entry_volume_not_empty() : u64 {
        abort 45
    }

    public fun port_entry_volume_not_match() : u64 {
        abort 47
    }

    public fun port_is_pause() : u64 {
        abort 17
    }

    public fun price_err() : u64 {
        abort 32
    }

    public fun price_not_exists() : u64 {
        abort 35
    }

    public fun price_not_updated() : u64 {
        abort 34
    }

    public fun price_object_not_match_with_coin_type() : u64 {
        abort 30
    }

    public fun pyth_oracle_info_already_exists() : u64 {
        abort 67
    }

    public fun quote_type_error() : u64 {
        abort 31
    }

    public fun remove_assets_not_empty() : u64 {
        abort 22
    }

    public fun reward_empty() : u64 {
        abort 54
    }

    public fun reward_growth_not_match() : u64 {
        abort 43
    }

    public fun reward_types_not_match() : u64 {
        abort 59
    }

    public fun switchboard_aggregator_not_match() : u64 {
        abort 65
    }

    public fun switchboard_oracle_info_already_exists() : u64 {
        abort 66
    }

    public fun token_amount_is_zero() : u64 {
        abort 3
    }

    public fun token_amount_not_enough() : u64 {
        abort 4
    }

    public fun token_amount_overflow() : u64 {
        abort 2
    }

    public fun treasury_cap_illegal() : u64 {
        abort 14
    }

    public fun update_price_fee_not_enough() : u64 {
        abort 33
    }

    public fun vault_is_stopped() : u64 {
        abort 69
    }

    public fun vault_not_stopped() : u64 {
        abort 70
    }

    public fun vault_started() : u64 {
        abort 61
    }

    public fun vault_stopped() : u64 {
        abort 60
    }

    public fun wrong_package_version() : u64 {
        abort 15
    }

    // decompiled from Move bytecode v6
}

