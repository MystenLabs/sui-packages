module 0x57ddc7eca0c73af80ae01507f489845ff284ae103e8d7264b09f61550fd41574::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun div_mul(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128) * (arg2 as u128)) as u64)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun pow_2(arg0: u256) : u256 {
        arg0 * arg0
    }

    // decompiled from Move bytecode v6
}

