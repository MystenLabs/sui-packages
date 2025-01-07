module 0x227f865230dd4fc947321619f56fee37dc7ac582eb22e3eab29816f717512d9d::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 10001);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u64 {
        assert!(arg2 > 0, 10001);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u64)
    }

    public fun mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0, 10001);
        arg0 * arg1 / arg2
    }

    public fun mul_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_u128_to_u256(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        let v0 = 0;
        if (arg0 > 3) {
            v0 = arg0;
            let v1 = arg0 / 2 + 1;
            while (v1 < arg0) {
                v0 = v1;
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
        } else if (arg0 != 0) {
            v0 = 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

