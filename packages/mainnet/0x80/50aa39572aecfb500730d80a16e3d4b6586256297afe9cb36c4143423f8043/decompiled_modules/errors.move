module 0x8050aa39572aecfb500730d80a16e3d4b6586256297afe9cb36c4143423f8043::errors {
    public fun bad_new_vault_version() : u64 {
        37
    }

    public fun cannot_force_withdraw() : u64 {
        4
    }

    public fun clearing_house_id_not_found() : u64 {
        27
    }

    public fun exceeding_max_total_deposited_collateral() : u64 {
        43
    }

    public fun force_withdraw_above_margin_ratio_tolerance() : u64 {
        13
    }

    public fun force_withdraw_below_margin_ratio() : u64 {
        9
    }

    public fun force_withdraw_delay_not_passed() : u64 {
        5
    }

    public fun force_withdraw_tolerance() : u64 {
        8
    }

    public fun invalid_collateral_pfs_tolerance() : u64 {
        42
    }

    public fun invalid_force_withdraw_delay() : u64 {
        29
    }

    public fun invalid_lock_period() : u64 {
        6
    }

    public fun invalid_lp_decimals() : u64 {
        44
    }

    public fun invalid_max_markets_in_vault() : u64 {
        40
    }

    public fun invalid_max_pending_orders_per_position() : u64 {
        39
    }

    public fun invalid_owner_fee_rate() : u64 {
        7
    }

    public fun invalid_sender() : u64 {
        45
    }

    public fun invalid_split_amount() : u64 {
        35
    }

    public fun invalid_version() : u64 {
        16
    }

    public fun lock_period_not_passed() : u64 {
        14
    }

    public fun max_markets_exceeded() : u64 {
        31
    }

    public fun max_pending_orders_exceeded() : u64 {
        32
    }

    public fun must_force_withdraw() : u64 {
        38
    }

    public fun negative_amount_to_withdraw() : u64 {
        36
    }

    public fun non_zero_total_supply() : u64 {
        3
    }

    public fun not_all_chs_processed() : u64 {
        17
    }

    public fun not_enough_collateral_balance() : u64 {
        2
    }

    public fun not_enough_fees() : u64 {
        33
    }

    public fun owner_locked_amount_not_enough() : u64 {
        25
    }

    public fun package_already_created() : u64 {
        21
    }

    public fun queue_is_empty() : u64 {
        18
    }

    public fun queue_is_not_empty() : u64 {
        19
    }

    public fun slippage_check() : u64 {
        1
    }

    public fun user_deposit_amount_not_enough() : u64 {
        26
    }

    public fun user_lp_calculation_negative() : u64 {
        34
    }

    public fun user_lp_calculation_zero() : u64 {
        24
    }

    public fun vault_temporarily_paused() : u64 {
        15
    }

    public fun withdraw_amount_too_big() : u64 {
        11
    }

    public fun withdraw_amount_zero() : u64 {
        10
    }

    public fun withdraw_request_already_exists() : u64 {
        28
    }

    public fun withdraw_request_does_not_exist() : u64 {
        30
    }

    public fun wrong_base_oracle() : u64 {
        23
    }

    public fun wrong_collateral_oracle() : u64 {
        22
    }

    public fun wrong_order_ids_in_force_withdraw() : u64 {
        12
    }

    public fun wrong_vault_for_session() : u64 {
        41
    }

    // decompiled from Move bytecode v6
}

