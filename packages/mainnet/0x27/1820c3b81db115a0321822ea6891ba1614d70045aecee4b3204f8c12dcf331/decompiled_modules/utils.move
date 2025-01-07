module 0x271820c3b81db115a0321822ea6891ba1614d70045aecee4b3204f8c12dcf331::utils {
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

    // decompiled from Move bytecode v6
}

