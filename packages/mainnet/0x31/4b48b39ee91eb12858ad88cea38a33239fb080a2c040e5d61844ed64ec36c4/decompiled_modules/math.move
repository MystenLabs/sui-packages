module 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::math {
    public fun div_round(arg0: u64, arg1: u64) : (bool, u64) {
        let (v0, v1) = unsafe_div_round(arg0, arg1);
        assert!(v1 > 0, 2);
        (v0, v1)
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 < 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun mul_round(arg0: u64, arg1: u64) : (bool, u64) {
        let (v0, v1) = unsafe_mul_round(arg0, arg1);
        assert!(v1 > 0, 2);
        (v0, v1)
    }

    public fun unsafe_div(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = unsafe_div_round(arg0, arg1);
        v1
    }

    public fun unsafe_div_round(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = true;
        if (v0 * 1000000000 % v1 == 0) {
            v2 = false;
        };
        (v2, ((v0 * 1000000000 / v1) as u64))
    }

    public fun unsafe_mul(arg0: u64, arg1: u64) : u64 {
        let (_, v1) = unsafe_mul_round(arg0, arg1);
        v1
    }

    fun unsafe_mul_round(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = true;
        if (v0 * v1 % 1000000000 == 0) {
            v2 = false;
        };
        (v2, ((v0 * v1 / 1000000000) as u64))
    }

    // decompiled from Move bytecode v6
}

