module 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

