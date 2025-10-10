module 0xbe22d5391b2abdfdc5808bd42d3a8d155c6789469e6185c99f2a641deb7bce0f::error {
    public fun aum_done_err() : u64 {
        abort 19
    }

    public fun deposit_amount_zero() : u64 {
        abort 18
    }

    public fun dlmm_market_not_initialized() : u64 {
        abort 25
    }

    public fun duplicate_certified_pool() : u64 {
        abort 35
    }

    public fun duplicate_market() : u64 {
        abort 16
    }

    public fun duplicate_position() : u64 {
        abort 2
    }

    public fun hard_cap_reached() : u64 {
        abort 21
    }

    public fun invalid_oracle_price() : u64 {
        abort 29
    }

    public fun invalid_price_feed_id() : u64 {
        abort 28
    }

    public fun invalid_protocol_fee_rate() : u64 {
        abort 14
    }

    public fun no_emergency_pause_permission() : u64 {
        abort 12
    }

    public fun no_oracle_manager_permission() : u64 {
        abort 11
    }

    public fun no_protocol_fee_claim_permission() : u64 {
        abort 10
    }

    public fun no_vault_manager_permission() : u64 {
        abort 13
    }

    public fun operation_not_allowed() : u64 {
        abort 20
    }

    public fun oracle_info_exists() : u64 {
        abort 26
    }

    public fun oracle_info_not_exists() : u64 {
        abort 27
    }

    public fun package_version_deprecate() : u64 {
        abort 9
    }

    public fun pool_not_match() : u64 {
        abort 3
    }

    public fun position_amounts_calculate_expired() : u64 {
        abort 5
    }

    public fun position_amounts_not_calculated() : u64 {
        abort 4
    }

    public fun position_not_found() : u64 {
        abort 6
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

    public fun quote_type_error() : u64 {
        abort 7
    }

    public fun token_amount_is_zero() : u64 {
        abort 22
    }

    public fun token_amount_overflow() : u64 {
        abort 23
    }

    public fun treasury_cap_illegal() : u64 {
        abort 8
    }

    public fun uncertified_pool() : u64 {
        abort 1
    }

    public fun update_price_fee_not_enough() : u64 {
        abort 33
    }

    public fun vault_not_allow_calculate_aum() : u64 {
        abort 24
    }

    public fun vault_not_allow_deposit() : u64 {
        abort 17
    }

    public fun vault_type_not_match() : u64 {
        abort 15
    }

    // decompiled from Move bytecode v6
}

