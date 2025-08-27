module 0xc0ea28df55ebbdac0f221c42b7c90c8dda0afd4a140522547b337daec7e56717::error {
    public fun already_initialized() : u64 {
        abort 50
    }

    public fun buffer_too_low() : u64 {
        abort 13
    }

    public fun calculation_overflow() : u64 {
        abort 2
    }

    public fun data_not_match_program() : u64 {
        abort 1
    }

    public fun deposit_paused() : u64 {
        abort 5
    }

    public fun equilibrate_debt_too_high() : u64 {
        abort 12
    }

    public fun exceed_borrow_cap() : u64 {
        abort 23
    }

    public fun exceed_borrow_limit() : u64 {
        abort 22
    }

    public fun health_factor_out_of_range() : u64 {
        abort 10
    }

    public fun health_factor_too_high() : u64 {
        abort 4
    }

    public fun insufficient_collateral() : u64 {
        abort 21
    }

    public fun invalid_config() : u64 {
        abort 51
    }

    public fun invalid_haedal_rate() : u64 {
        abort 31
    }

    public fun invalid_health_factor() : u64 {
        abort 3
    }

    public fun invalid_hf() : u64 {
        abort 26
    }

    public fun invalid_ltv() : u64 {
        abort 25
    }

    public fun invalid_parameters() : u64 {
        abort 24
    }

    public fun left_value_less() : u64 {
        abort 53
    }

    public fun max_borrow_cap_reached() : u64 {
        abort 7
    }

    public fun max_supply_cap_reached() : u64 {
        abort 8
    }

    public fun reward_too_low() : u64 {
        abort 11
    }

    public fun value_less_zero() : u64 {
        abort 52
    }

    public fun withdraw_amount_insufficient() : u64 {
        abort 9
    }

    public fun withdraw_paused() : u64 {
        abort 6
    }

    // decompiled from Move bytecode v6
}

