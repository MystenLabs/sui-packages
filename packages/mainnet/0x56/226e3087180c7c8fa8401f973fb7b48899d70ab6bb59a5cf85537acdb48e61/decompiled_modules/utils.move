module 0x909cdaa57defd1e882056b3aa270a471b953e8c21414b0ec32b4eb9a08c325c5::utils {
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

