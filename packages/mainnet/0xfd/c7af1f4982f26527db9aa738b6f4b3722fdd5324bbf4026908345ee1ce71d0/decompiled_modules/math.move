module 0xfdc7af1f4982f26527db9aa738b6f4b3722fdd5324bbf4026908345ee1ce71d0::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            abort 0
        };
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        if (v0 > (18446744073709551615 as u128)) {
            abort 1
        };
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

