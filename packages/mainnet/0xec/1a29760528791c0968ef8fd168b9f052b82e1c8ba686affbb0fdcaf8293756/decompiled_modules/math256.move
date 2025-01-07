module 0xec1a29760528791c0968ef8fd168b9f052b82e1c8ba686affbb0fdcaf8293756::math256 {
    public fun div(arg0: u256, arg1: u256) : u256 {
        arg0 / arg1
    }

    public fun div_mul(arg0: u256, arg1: u256, arg2: u256) : u256 {
        (((arg0 as u128) / (arg1 as u128) * (arg2 as u128)) as u256)
    }

    public fun mul_div(arg0: u256, arg1: u256, arg2: u256) : u256 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u256)
    }

    public fun pow_2(arg0: u256) : u256 {
        arg0 * arg0
    }

    // decompiled from Move bytecode v6
}

