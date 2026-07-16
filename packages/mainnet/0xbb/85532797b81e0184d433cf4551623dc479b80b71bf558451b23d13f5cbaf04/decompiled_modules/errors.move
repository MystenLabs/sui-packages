module 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::errors {
    public(friend) fun bad_new_vault_version() : u64 {
        37
    }

    public(friend) fun bad_oracle_price() : u64 {
        52
    }

    public(friend) fun cannot_force_withdraw() : u64 {
        4
    }

    public(friend) fun clearing_house_id_not_found() : u64 {
        27
    }

    public(friend) fun exceeding_max_total_deposited_collateral() : u64 {
        43
    }

    public(friend) fun force_withdraw_above_margin_ratio_tolerance() : u64 {
        13
    }

    public(friend) fun force_withdraw_below_margin_ratio() : u64 {
        9
    }

    public(friend) fun force_withdraw_collateral_leftover() : u64 {
        47
    }

    public(friend) fun force_withdraw_delay_not_passed() : u64 {
        5
    }

    public(friend) fun force_withdraw_tolerance() : u64 {
        8
    }

    public(friend) fun invalid_collateral_pfs_tolerance() : u64 {
        42
    }

    public(friend) fun invalid_decimals() : u64 {
        51
    }

    public(friend) fun invalid_force_withdraw_delay() : u64 {
        29
    }

    public(friend) fun invalid_lock_period() : u64 {
        6
    }

    public(friend) fun invalid_max_markets_in_vault() : u64 {
        40
    }

    public(friend) fun invalid_max_pending_orders_per_position() : u64 {
        39
    }

    public(friend) fun invalid_owner_fee_rate() : u64 {
        7
    }

    public(friend) fun invalid_resume_version() : u64 {
        55
    }

    public(friend) fun invalid_sender() : u64 {
        45
    }

    public(friend) fun invalid_split_amount() : u64 {
        35
    }

    public(friend) fun invalid_vault_assistant_cap() : u64 {
        48
    }

    public(friend) fun invalid_version() : u64 {
        16
    }

    public(friend) fun lock_period_not_passed() : u64 {
        14
    }

    public(friend) fun max_markets_exceeded() : u64 {
        31
    }

    public(friend) fun max_pending_orders_exceeded() : u64 {
        32
    }

    public(friend) fun must_force_withdraw() : u64 {
        38
    }

    public(friend) fun negative_amount_to_withdraw() : u64 {
        36
    }

    public(friend) fun non_positive_market_margin() : u64 {
        53
    }

    public(friend) fun non_zero_total_supply() : u64 {
        3
    }

    public(friend) fun not_all_chs_processed() : u64 {
        17
    }

    public(friend) fun not_enough_collateral_balance() : u64 {
        2
    }

    public(friend) fun not_enough_fees() : u64 {
        33
    }

    public(friend) fun not_frozen() : u64 {
        54
    }

    public(friend) fun owner_locked_amount_not_enough() : u64 {
        25
    }

    public(friend) fun owner_locked_amount_too_big() : u64 {
        51
    }

    public(friend) fun owner_locked_amount_too_low_after_withdraw() : u64 {
        49
    }

    public(friend) fun package_already_created() : u64 {
        21
    }

    public(friend) fun pause_vault_for_force_withdraw_too_frequent() : u64 {
        46
    }

    public(friend) fun queue_is_empty() : u64 {
        18
    }

    public(friend) fun queue_is_not_empty() : u64 {
        19
    }

    public(friend) fun slippage_check() : u64 {
        1
    }

    public(friend) fun too_many_assistants() : u64 {
        50
    }

    public(friend) fun user_deposit_amount_not_enough() : u64 {
        26
    }

    public(friend) fun user_lp_calculation_negative() : u64 {
        34
    }

    public(friend) fun user_lp_calculation_zero() : u64 {
        24
    }

    public(friend) fun vault_temporarily_paused() : u64 {
        15
    }

    public(friend) fun withdraw_amount_too_big() : u64 {
        11
    }

    public(friend) fun withdraw_amount_zero() : u64 {
        10
    }

    public(friend) fun withdraw_request_already_exists() : u64 {
        28
    }

    public(friend) fun withdraw_request_does_not_exist() : u64 {
        30
    }

    public(friend) fun wrong_base_oracle() : u64 {
        23
    }

    public(friend) fun wrong_collateral_oracle() : u64 {
        22
    }

    public(friend) fun wrong_order_ids_in_force_withdraw() : u64 {
        12
    }

    public(friend) fun wrong_vault_for_session() : u64 {
        41
    }

    // decompiled from Move bytecode v7
}

