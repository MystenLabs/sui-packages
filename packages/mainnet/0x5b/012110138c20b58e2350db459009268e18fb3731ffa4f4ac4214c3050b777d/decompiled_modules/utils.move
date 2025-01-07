module 0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::utils {
    public fun calc_sqrt_limit_price_with_slippage(arg0: u128, arg1: u64, arg2: bool) : u128 {
        let v0 = if (arg2) {
            18446744073709551616 + 18446744073709551616 * (arg1 as u128) / (1000000 as u128)
        } else {
            18446744073709551616 - 18446744073709551616 * (arg1 as u128) / (1000000 as u128)
        };
        scale(arg0, v0)
    }

    fun scale(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (1000000 as u256)) as u128)
    }

    public fun slippage_scaling() : u64 {
        1000000
    }

    // decompiled from Move bytecode v6
}

