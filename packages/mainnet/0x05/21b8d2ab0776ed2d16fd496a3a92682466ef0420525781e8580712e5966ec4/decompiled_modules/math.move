module 0x521b8d2ab0776ed2d16fd496a3a92682466ef0420525781e8580712e5966ec4::math {
    public fun bps() : u64 {
        10000
    }

    public fun bps_of(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 10000)
    }

    public fun bps_of_up(arg0: u64, arg1: u64) : u64 {
        mul_div_up(arg0, arg1, 10000)
    }

    public fun div_up_u128(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 != 0, 1);
        (arg0 + arg1 - 1) / arg1
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 1);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 2);
        (v0 as u64)
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 1);
        let v0 = (arg2 as u128);
        let v1 = ((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0;
        assert!(v1 <= 18446744073709551615, 2);
        (v1 as u64)
    }

    public fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        assert!(arg0 != 0, 1);
        let v0 = sqrt_u256(((arg1 as u256) << 128) / (arg0 as u256));
        assert!(v0 <= 340282366920938463463374607431768211455, 2);
        (v0 as u128)
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = arg0 / 2 + 1;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 2);
        (arg0 as u64)
    }

    // decompiled from Move bytecode v7
}

