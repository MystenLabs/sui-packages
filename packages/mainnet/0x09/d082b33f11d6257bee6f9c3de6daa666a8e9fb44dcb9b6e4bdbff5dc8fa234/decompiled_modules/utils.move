module 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::utils {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = u128_mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun u128_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(arg2 > 0, 0);
        v0 / arg2 * v1 + v0 % arg2 * v1 / arg2
    }

    // decompiled from Move bytecode v6
}

