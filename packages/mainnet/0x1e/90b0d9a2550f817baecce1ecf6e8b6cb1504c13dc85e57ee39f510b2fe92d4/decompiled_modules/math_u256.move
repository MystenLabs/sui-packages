module 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::math_u256 {
    public fun add_check(arg0: u256, arg1: u256) : bool {
        115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0 >= arg1
    }

    public fun checked_shlw(arg0: u256) : (u256, bool) {
        if (arg0 >= 6277101735386680763835789423207666416102355444464034512896) {
            (0, true)
        } else {
            (arg0 << 64, false)
        }
    }

    public fun div_mod(arg0: u256, arg1: u256) : (u256, u256) {
        let v0 = arg0 / arg1;
        (v0, arg0 - v0 * arg1)
    }

    public fun div_round(arg0: u256, arg1: u256, arg2: bool) : u256 {
        assert!(arg1 > 0, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::integer_error::div_by_zero());
        if (arg2 && arg0 % arg1 > 0) {
            return arg0 / arg1 + 1
        };
        arg0 / arg1
    }

    public fun overflow_add(arg0: u256, arg1: u256) : u256 {
        if (!add_check(arg0, arg1)) {
            arg1 - 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0 - 1
        } else {
            arg0 + arg1
        }
    }

    public fun shlw(arg0: u256) : u256 {
        arg0 << 64
    }

    public fun shrw(arg0: u256) : u256 {
        arg0 >> 64
    }

    // decompiled from Move bytecode v6
}

