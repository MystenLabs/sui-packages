module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::errors {
    public fun e_expired() : u64 {
        10
    }

    public fun e_insufficient_buffer() : u64 {
        12
    }

    public fun e_invalid_config() : u64 {
        11
    }

    public fun e_leg_count_mismatch() : u64 {
        26
    }

    public fun e_leg_limit_exceeded() : u64 {
        15
    }

    public fun e_locked() : u64 {
        8
    }

    public fun e_methodology_mismatch() : u64 {
        6
    }

    public fun e_nav_delta_too_large() : u64 {
        22
    }

    public fun e_nav_out_of_bounds() : u64 {
        13
    }

    public fun e_oracle_inconsistent() : u64 {
        19
    }

    public fun e_oracle_low_confidence() : u64 {
        18
    }

    public fun e_oracle_stale() : u64 {
        17
    }

    public fun e_paused() : u64 {
        1
    }

    public fun e_rebalance_invariant() : u64 {
        27
    }

    public fun e_registry_mismatch() : u64 {
        21
    }

    public fun e_result_overflow() : u64 {
        25
    }

    public fun e_router_limit_exceeded() : u64 {
        16
    }

    public fun e_slippage_mint() : u64 {
        3
    }

    public fun e_slippage_redeem() : u64 {
        4
    }

    public fun e_ticket_vault_mismatch() : u64 {
        20
    }

    public fun e_timelock_not_elapsed() : u64 {
        9
    }

    public fun e_tvl_cap_exceeded() : u64 {
        5
    }

    public fun e_unauthorized() : u64 {
        7
    }

    public fun e_vault_already_locked() : u64 {
        24
    }

    public fun e_vault_not_fresh() : u64 {
        14
    }

    public fun e_vault_not_locked() : u64 {
        23
    }

    public fun e_zero_input() : u64 {
        2
    }

    public fun e_zero_output() : u64 {
        28
    }

    // decompiled from Move bytecode v7
}

