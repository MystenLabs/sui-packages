module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors {
    public fun e_admin_unauthorized() : u64 {
        100
    }

    public fun e_already_graduated() : u64 {
        1101
    }

    public fun e_bc_insufficient_reserve() : u64 {
        1003
    }

    public fun e_bc_sealed() : u64 {
        1000
    }

    public fun e_bc_slippage() : u64 {
        1002
    }

    public fun e_bc_zero_input() : u64 {
        1001
    }

    public fun e_distribute_exceeds_pool() : u64 {
        702
    }

    public fun e_distribute_length_mismatch() : u64 {
        701
    }

    public fun e_graduation_threshold_not_met() : u64 {
        1100
    }

    public fun e_launch_bad_decimals() : u64 {
        902
    }

    public fun e_launch_bad_dial() : u64 {
        903
    }

    public fun e_launch_bad_fee() : u64 {
        900
    }

    public fun e_launch_bad_interval() : u64 {
        904
    }

    public fun e_launch_bad_mcap() : u64 {
        905
    }

    public fun e_launch_bad_supply() : u64 {
        901
    }

    public fun e_not_graduated() : u64 {
        1102
    }

    public fun e_registry_already_registered() : u64 {
        200
    }

    public fun e_registry_not_found() : u64 {
        201
    }

    public fun e_registry_paused() : u64 {
        202
    }

    public fun e_safeguard_anti_snipe() : u64 {
        600
    }

    public fun e_safeguard_max_wallet() : u64 {
        601
    }

    public fun e_safeguard_threshold_not_met() : u64 {
        602
    }

    public fun e_snapshot_in_future() : u64 {
        703
    }

    public fun e_snapshot_too_fresh() : u64 {
        704
    }

    public fun e_snapshot_too_old() : u64 {
        705
    }

    public fun e_tax_invalid_bps() : u64 {
        500
    }

    public fun e_tick_cadence_locked() : u64 {
        700
    }

    public fun e_treasury_insufficient() : u64 {
        301
    }

    public fun e_treasury_zero_withdraw() : u64 {
        300
    }

    public fun e_vault_overflow() : u64 {
        401
    }

    public fun e_vault_zero_supply() : u64 {
        400
    }

    // decompiled from Move bytecode v6
}

