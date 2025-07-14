module 0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0xbdd206795d752c347646a8be991edf30f8dc253b21c2b99a2bf485a2e27355db::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
    }

    public fun max_fee_pips() : u64 {
        1000000
    }

    public fun max_fee_pips_u128() : u128 {
        (1000000 as u128)
    }

    public fun max_fee_pips_u256() : u256 {
        (1000000 as u256)
    }

    // decompiled from Move bytecode v6
}

