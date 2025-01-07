module 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::math256 {
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

