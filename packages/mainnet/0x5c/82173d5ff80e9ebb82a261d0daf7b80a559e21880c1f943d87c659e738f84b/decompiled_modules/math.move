module 0x5c82173d5ff80e9ebb82a261d0daf7b80a559e21880c1f943d87c659e738f84b::math {
    public fun from_shares(arg0: u256, arg1: u64) : u64 {
        assert!(arg0 != 0, 500);
        let v0 = (arg1 as u256) * 1000000000000000000 / arg0;
        assert!(v0 <= (18446744073709551615 as u256), 501);
        (v0 as u64)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    public fun mul_div_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) * (arg3 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    public fun ratio(arg0: u64, arg1: u64) : u256 {
        if (arg1 == 0) {
            return 1000000000000000000
        };
        let v0 = (arg0 as u256) * 1000000000000000000 / (arg1 as u256);
        assert!(v0 <= 1000000000000000000, 502);
        v0
    }

    public fun to_shares(arg0: u256, arg1: u64) : u64 {
        let v0 = (arg1 as u256) * arg0 / 1000000000000000000;
        let v1 = v0;
        assert!(v0 <= (18446744073709551615 as u256), 501);
        if (arg1 > 0 && v0 == 0) {
            v1 = 1;
        };
        (v1 as u64)
    }

    // decompiled from Move bytecode v6
}

