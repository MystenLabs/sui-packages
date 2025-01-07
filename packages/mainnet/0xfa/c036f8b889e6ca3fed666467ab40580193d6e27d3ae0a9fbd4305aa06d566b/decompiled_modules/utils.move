module 0xfac036f8b889e6ca3fed666467ab40580193d6e27d3ae0a9fbd4305aa06d566b::utils {
    public fun calc_sqrt_limit_price_with_slippage(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        if (arg1 == 0 && arg2 == 0) {
            if (arg3) {
                4295048017
            } else {
                79226673515401279992447579054
            }
        } else if (arg3) {
            scale(arg0, arg2)
        } else {
            scale(arg0, arg1)
        }
    }

    fun scale(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (18446744073709551616 as u256)) as u128)
    }

    // decompiled from Move bytecode v6
}

