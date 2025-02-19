module 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::math {
    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 1000000;
        if (v0 > 18446744073709551615) {
            abort 1
        };
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

