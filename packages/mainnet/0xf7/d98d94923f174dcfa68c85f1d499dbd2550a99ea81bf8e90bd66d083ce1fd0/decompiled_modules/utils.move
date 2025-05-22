module 0xf7d98d94923f174dcfa68c85f1d499dbd2550a99ea81bf8e90bd66d083ce1fd0::utils {
    public fun get_remain_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 >= arg2) {
            0
        } else if (arg3 <= arg1) {
            arg0
        } else {
            mul_div(arg0, arg2 - arg3, arg2 - arg1)
        }
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

