module 0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::constants {
    public fun amount_after_fee(arg0: u64, arg1: u64) : u64 {
        0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::safe_math::mul_div_u64(arg0, 1000000 - arg1, 1000000)
    }

    public fun amount_before_fee(arg0: u64, arg1: u64) : u64 {
        0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::safe_math::mul_div_u64(arg0, 1000000, 1000000 - arg1)
    }

    public fun current_version() : u64 {
        1
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

