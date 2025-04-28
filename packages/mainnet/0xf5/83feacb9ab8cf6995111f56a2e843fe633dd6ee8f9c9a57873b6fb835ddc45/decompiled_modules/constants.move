module 0xf583feacb9ab8cf6995111f56a2e843fe633dd6ee8f9c9a57873b6fb835ddc45::constants {
    public fun multiplier() : u256 {
        100000000000000000000
    }

    public fun oracle_manager_role() : u8 {
        5
    }

    public fun package_version() : u64 {
        1
    }

    public fun pool_compound_role() : u8 {
        1
    }

    public fun pool_fee_claim_role() : u8 {
        0
    }

    public fun pool_manager_role() : u8 {
        3
    }

    public fun pool_rebalance_role() : u8 {
        2
    }

    public fun reward_scale_factor() : u128 {
        1000000000
    }

    public fun rewarder_manager_role() : u8 {
        4
    }

    public fun uint64_max() : u256 {
        18446744073709551616
    }

    // decompiled from Move bytecode v6
}

