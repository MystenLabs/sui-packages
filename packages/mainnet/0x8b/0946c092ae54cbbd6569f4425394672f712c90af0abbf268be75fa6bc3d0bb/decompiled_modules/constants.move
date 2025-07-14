module 0x8b0946c092ae54cbbd6569f4425394672f712c90af0abbf268be75fa6bc3d0bb::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0x8b0946c092ae54cbbd6569f4425394672f712c90af0abbf268be75fa6bc3d0bb::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0x8b0946c092ae54cbbd6569f4425394672f712c90af0abbf268be75fa6bc3d0bb::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
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

