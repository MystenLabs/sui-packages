module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed {
    public fun add(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun isqrt(arg0: u128) : u128 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = 0;
        while (arg0 > 0) {
            v0 = v0 + 1;
            arg0 = arg0 >> 1;
        };
        let v1 = 1 << (v0 + 1) / 2;
        loop {
            let v2 = (v1 + arg0 / v1) / 2;
            if (v2 >= v1) {
                break
            };
            v1 = v2;
        };
        v1
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = (arg2 as u256);
        let v2 = v0 / v1;
        let v3 = v2;
        if (arg3 && v0 % v1 != 0) {
            v3 = v2 + 1;
        };
        assert!(v3 <= 340282366920938463463374607431768211455, 0);
        (v3 as u128)
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128), arg3);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    public fun wad() : u64 {
        1000000000000000000
    }

    public fun wad_mul(arg0: u64, arg1: u64, arg2: bool) : u64 {
        mul_div_u64(arg0, arg1, 1000000000000000000, arg2)
    }

    // decompiled from Move bytecode v7
}

