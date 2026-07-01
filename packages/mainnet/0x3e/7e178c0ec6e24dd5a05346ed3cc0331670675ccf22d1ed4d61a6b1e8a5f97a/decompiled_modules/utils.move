module 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::utils {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = u128_mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= (18446744073709551615 as u128), 101);
        (v0 as u64)
    }

    public fun u128_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(arg2 > 0, 101);
        v0 / arg2 * v1 + v0 % arg2 * v1 / arg2
    }

    // decompiled from Move bytecode v7
}

