module 0x5f575f41558a5070065fc1ee52cf4c502a26423c7e71909efa0f95d09b2a53c0::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0x5f575f41558a5070065fc1ee52cf4c502a26423c7e71909efa0f95d09b2a53c0::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0x5f575f41558a5070065fc1ee52cf4c502a26423c7e71909efa0f95d09b2a53c0::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
    }

    public fun auto_claim_source() : u64 {
        7
    }

    public fun auto_compound_source() : u64 {
        5
    }

    public fun auto_exit_source() : u64 {
        6
    }

    public fun auto_rebalance_source() : u64 {
        4
    }

    public fun compound_source() : u64 {
        1
    }

    public fun current_version() : u64 {
        1
    }

    public fun rebalance_source() : u64 {
        0
    }

    public fun scaling_pips() : u64 {
        1000000
    }

    public fun scaling_pips_u128() : u128 {
        (1000000 as u128)
    }

    public fun scaling_pips_u256() : u256 {
        (1000000 as u256)
    }

    public fun zap_in_source() : u64 {
        2
    }

    public fun zap_out_source() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

