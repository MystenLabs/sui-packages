module 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::math {
    public fun compute_weight(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg1 >= arg2 && arg1 <= arg3, 1);
        let v0 = mul_factor(arg0, arg1, arg3);
        assert!(v0 > 0, 2);
        v0
    }

    public fun has_duplicates<T0>(arg0: &vector<T0>) : bool {
        let v0 = 0x1::vector::length<T0>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<T0>(arg0, v1);
            let v3 = v1 + 1;
            while (v3 < v0) {
                if (v2 == 0x1::vector::borrow<T0>(arg0, v3)) {
                    return true
                };
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun mul_div_down(arg0: u256, arg1: u256, arg2: u256) : u256 {
        arg0 * arg1 / arg2
    }

    public fun mul_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) / 2) / (arg2 as u128)) as u64)
    }

    public fun mul_factor_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 0);
        (arg0 * arg1 + arg2 / 2) / arg2
    }

    public fun try_mul(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            return (true, 0)
        };
        if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            (false, 0)
        } else {
            (true, arg0 * arg1)
        }
    }

    public fun try_mul_div_down(arg0: u256, arg1: u256, arg2: u256) : (bool, u256) {
        if (arg2 == 0) {
            return (false, 0)
        };
        let (v0, _) = try_mul(arg0, arg1);
        if (!v0) {
            return (false, 0)
        };
        (true, mul_div_down(arg0, arg1, arg2))
    }

    public fun x_is_percent_so_to_100_need(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg1 > 100
        };
        if (v0) {
            return 0
        };
        arg0 * 100 / arg1 - arg0
    }

    // decompiled from Move bytecode v6
}

