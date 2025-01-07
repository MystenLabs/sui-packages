module 0x567c4e6cfda46287d193ce23d44a0b912311f4daf957bb9362a4f289f023273f::math {
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

