module 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = arg0 * arg1 / arg2;
        assert!(!(v0 > (18446744073709551615 as u128)), 501);
        (v0 as u64)
    }

    public fun mul_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun sqrt(arg0: u128) : u64 {
        if (arg0 < 4) {
            if (arg0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            (arg0 as u64)
        }
    }

    // decompiled from Move bytecode v6
}

