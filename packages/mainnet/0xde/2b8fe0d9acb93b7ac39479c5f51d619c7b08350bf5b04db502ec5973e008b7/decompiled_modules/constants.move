module 0xc86566ecf61a57d6ec53971798a611dc09482b453ac532f6c4a338c247255235::constants {
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

