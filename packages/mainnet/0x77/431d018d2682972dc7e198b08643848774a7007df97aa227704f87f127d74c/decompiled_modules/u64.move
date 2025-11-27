module 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

