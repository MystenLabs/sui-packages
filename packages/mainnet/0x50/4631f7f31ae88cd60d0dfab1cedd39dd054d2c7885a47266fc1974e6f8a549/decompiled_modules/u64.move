module 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

