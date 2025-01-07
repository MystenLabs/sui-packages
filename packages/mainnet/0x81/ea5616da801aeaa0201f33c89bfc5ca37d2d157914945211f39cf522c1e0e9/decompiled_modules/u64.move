module 0x81ea5616da801aeaa0201f33c89bfc5ca37d2d157914945211f39cf522c1e0e9::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x81ea5616da801aeaa0201f33c89bfc5ca37d2d157914945211f39cf522c1e0e9::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

