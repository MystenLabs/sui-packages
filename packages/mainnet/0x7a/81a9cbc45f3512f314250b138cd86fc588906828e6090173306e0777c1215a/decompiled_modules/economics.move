module 0x7a81a9cbc45f3512f314250b138cd86fc588906828e6090173306e0777c1215a::economics {
    public fun charged_units(arg0: u64) : u64 {
        divide_and_round_up(arg0, 1048576)
    }

    public fun divide_and_round_up(arg0: u64, arg1: u64) : u64 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun extend_epochs(arg0: u32, arg1: u32) : u32 {
        arg1 - arg0
    }

    public fun pow_u128(arg0: u128, arg1: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * arg0;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_cap(arg0: u64, arg1: u64, arg2: u32) : u64 {
        (((arg0 as u128) * (arg1 as u128) * (arg2 as u128)) as u64)
    }

    public fun tip_capped(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            0
        };
        let v1 = (((arg3 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        let v2 = arg0;
        if (arg0 > v0) {
            v2 = v0;
        };
        if (v2 > v1) {
            v2 = v1;
        };
        v2
    }

    public fun tip_raw(arg0: u32, arg1: u32, arg2: u32, arg3: u8, arg4: u64, arg5: u64) : u64 {
        if (arg2 <= arg1) {
            return arg5
        };
        let v0 = if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        };
        arg4 + ((((arg5 - arg4) as u128) * pow_u128(((arg2 - v0) as u128), arg3) / pow_u128(((arg2 - arg1) as u128), arg3)) as u64)
    }

    public fun window_of(arg0: u32, arg1: u32) : u32 {
        arg0 / arg1
    }

    // decompiled from Move bytecode v7
}

