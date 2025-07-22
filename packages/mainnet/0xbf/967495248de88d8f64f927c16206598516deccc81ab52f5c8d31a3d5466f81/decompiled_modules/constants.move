module 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
    }

    public fun compound_fee_source() : u64 {
        1
    }

    public fun current_version() : u64 {
        1
    }

    public fun rebalance_fee_source() : u64 {
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

    public fun zap_in_fee_source() : u64 {
        2
    }

    public fun zap_out_fee_source() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

