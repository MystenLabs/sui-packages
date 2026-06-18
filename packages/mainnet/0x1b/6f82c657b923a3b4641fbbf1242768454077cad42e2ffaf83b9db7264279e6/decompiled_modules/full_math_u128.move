module 0x1b6f82c657b923a3b4641fbbf1242768454077cad42e2ffaf83b9db7264279e6::full_math_u128 {
    public fun full_mul(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = (arg2 as u256);
        let v1 = full_mul(arg0, arg1);
        let v2 = v1 / v0;
        let v3 = v2;
        if (v1 % v0 != 0) {
            v3 = v2 + 1;
        };
        assert!(v3 <= 340282366920938463463374607431768211455, 0);
        (v3 as u128)
    }

    public fun mul_div_floor(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = full_mul(arg0, arg1) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 0);
        (v0 as u128)
    }

    public fun mul_div_round(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = (arg2 as u256);
        let v1 = full_mul(arg0, arg1);
        let v2 = v1 / v0;
        let v3 = v2;
        let v4 = v1 % v0;
        if (v4 != 0 && v4 >= v0 - v4) {
            v3 = v2 + 1;
        };
        assert!(v3 <= 340282366920938463463374607431768211455, 0);
        (v3 as u128)
    }

    // decompiled from Move bytecode v7
}

