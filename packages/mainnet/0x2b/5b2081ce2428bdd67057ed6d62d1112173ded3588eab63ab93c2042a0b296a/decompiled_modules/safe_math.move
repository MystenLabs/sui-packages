module 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math {
    public fun safe_add_u256(arg0: u256, arg1: u256) : u256 {
        assert!(115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0 >= arg1, 1000);
        arg0 + arg1
    }

    public fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(18446744073709551615 - arg0 >= arg1, 1000);
        arg0 + arg1
    }

    public fun safe_div_u256(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 1002);
        arg0 / arg1
    }

    public fun safe_div_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 != 0, 1002);
        arg0 / arg1
    }

    public fun safe_mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 1002);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            return arg0 * arg1 / arg2
        };
        safe_add_u256(safe_mul_u256(arg0 / arg2, arg1), safe_div_u256(safe_mul_u256(arg0 % arg2, arg1), arg2))
    }

    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 1002);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= (18446744073709551615 as u256), 1000);
        (v0 as u64)
    }

    public fun safe_mul_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0 >= arg1, 1003);
        arg0 * arg1
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(18446744073709551615 / arg0 >= arg1, 1003);
        arg0 * arg1
    }

    public fun safe_sub_u256(arg0: u256, arg1: u256) : u256 {
        assert!(arg0 >= arg1, 1001);
        arg0 - arg1
    }

    public fun safe_sub_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 1001);
        arg0 - arg1
    }

    public fun will_add_overflow_u256(arg0: u256, arg1: u256) : bool {
        115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0 < arg1
    }

    public fun will_add_overflow_u64(arg0: u64, arg1: u64) : bool {
        18446744073709551615 - arg0 < arg1
    }

    public fun will_mul_overflow_u256(arg0: u256, arg1: u256) : bool {
        if (arg0 == 0 || arg1 == 0) {
            return false
        };
        115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0 < arg1
    }

    public fun will_mul_overflow_u64(arg0: u64, arg1: u64) : bool {
        if (arg0 == 0 || arg1 == 0) {
            return false
        };
        18446744073709551615 / arg0 < arg1
    }

    // decompiled from Move bytecode v6
}

