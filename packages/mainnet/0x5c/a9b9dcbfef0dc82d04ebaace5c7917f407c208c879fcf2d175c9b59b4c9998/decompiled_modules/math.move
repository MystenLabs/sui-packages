module 0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0);
        let v0 = (arg2 as u128);
        let v1 = ((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0;
        assert!(v1 <= 18446744073709551615, 1);
        (v1 as u64)
    }

    // decompiled from Move bytecode v7
}

