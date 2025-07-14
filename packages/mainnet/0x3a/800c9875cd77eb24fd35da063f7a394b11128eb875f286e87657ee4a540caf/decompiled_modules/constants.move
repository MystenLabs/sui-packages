module 0x5dfa0ae0784f0165a7b70d2d7f8e8dd2aa936e65266f77b6272876b9b0b90840::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0x5dfa0ae0784f0165a7b70d2d7f8e8dd2aa936e65266f77b6272876b9b0b90840::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0x5dfa0ae0784f0165a7b70d2d7f8e8dd2aa936e65266f77b6272876b9b0b90840::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
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

