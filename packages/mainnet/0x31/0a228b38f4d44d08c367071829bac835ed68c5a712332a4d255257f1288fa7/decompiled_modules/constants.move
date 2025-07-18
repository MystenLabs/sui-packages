module 0x7285a36371bfa08508b0580f61c30ff4f3dbd3a5747523313563492ff4b7ed8e::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0x7285a36371bfa08508b0580f61c30ff4f3dbd3a5747523313563492ff4b7ed8e::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0x7285a36371bfa08508b0580f61c30ff4f3dbd3a5747523313563492ff4b7ed8e::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
    }

    public fun current_version() : u64 {
        1
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

    // decompiled from Move bytecode v6
}

