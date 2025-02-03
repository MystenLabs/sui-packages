module 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

