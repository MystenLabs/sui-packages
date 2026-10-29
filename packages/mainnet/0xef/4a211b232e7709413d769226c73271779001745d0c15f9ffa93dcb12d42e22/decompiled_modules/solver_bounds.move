module 0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::solver_bounds {
    public fun ceil_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 0);
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        arg0 / arg1 + v0
    }

    public fun pt_fits_budget(arg0: u64, arg1: u128, arg2: u128, arg3: u64) : bool {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return false
        };
        (arg1 as u256) * 18446744073709551616 >= (arg2 as u256) * 0x1::u256::max(18446744073709551616, ceil_div((arg0 as u256) * 18446744073709551616, (arg3 as u256)))
    }

    public fun pt_input_bound(arg0: u64, arg1: u128, arg2: u128, arg3: u128) : u256 {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = ceil_div((arg0 as u256) * (arg1 as u256), 18446744073709551616);
        if (v1 > 18446744073709551615) {
            return 115792089237316195423570985008687907853269984665640564039457584007913129639935
        };
        let v2 = ceil_div(v1 * (arg2 as u256), 18446744073709551616);
        if (v2 > 18446744073709551615) {
            return 115792089237316195423570985008687907853269984665640564039457584007913129639935
        };
        ceil_div(v2 * (arg3 as u256), 18446744073709551616)
    }

    public fun yt_rate_bound(arg0: u64, arg1: u128, arg2: u128, arg3: u128) : u256 {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = ceil_div(18446744073709551616 * 18446744073709551616, (arg1 as u256));
        let v2 = 18446744073709551616 * 18446744073709551616 * 18446744073709551616 / (arg3 as u256) * (arg2 as u256);
        if (v1 <= v2) {
            return 115792089237316195423570985008687907853269984665640564039457584007913129639935
        };
        ceil_div((arg0 as u256) * 18446744073709551616, v1 - v2)
    }

    public fun yt_repayment_bound(arg0: u64, arg1: u64, arg2: u128) : u256 {
        ceil_div(((arg0 as u256) + (arg1 as u256)) * (arg2 as u256), 18446744073709551616)
    }

    // decompiled from Move bytecode v7
}

