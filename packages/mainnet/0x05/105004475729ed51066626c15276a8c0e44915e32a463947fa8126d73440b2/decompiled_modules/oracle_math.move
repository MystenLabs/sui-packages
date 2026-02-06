module 0x5105004475729ed51066626c15276a8c0e44915e32a463947fa8126d73440b2::oracle_math {
    public fun add_checked(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455 - arg1, 1);
        arg0 + arg1
    }

    public fun mul_checked(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 340282366920938463463374607431768211455 / arg1, 1);
        arg0 * arg1
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 0);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 1);
        (v0 as u128)
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 0);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = (arg2 as u256);
        let v2 = v0 / v1;
        let v3 = v2;
        if (v0 % v1 > 0) {
            v3 = v2 + 1;
        };
        assert!(v3 <= 340282366920938463463374607431768211455, 1);
        (v3 as u128)
    }

    public fun pow10(arg0: u32) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = mul_checked(v0, 10);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

