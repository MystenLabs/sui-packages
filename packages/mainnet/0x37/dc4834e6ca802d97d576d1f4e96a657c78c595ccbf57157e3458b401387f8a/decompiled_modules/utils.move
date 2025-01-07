module 0x37dc4834e6ca802d97d576d1f4e96a657c78c595ccbf57157e3458b401387f8a::utils {
    public fun adjust_difficulty_by_diff(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg2 == arg1
        };
        if (v0) {
            return arg0
        };
        let v1 = arg2 * 100 / arg1;
        let v2 = v1;
        if (v1 > 400) {
            v2 = 400;
        } else if (v1 < 25) {
            v2 = 25;
        };
        let v3 = 1766847064778384329583297500742918515827483896875618958121606201292619775;
        if (v2 > 100 && arg0 >= v3) {
            return arg0
        };
        let v4 = arg0 / 100;
        let v5 = v4;
        if (v4 == 0) {
            v5 = 1;
        };
        if (v2 <= 100) {
            return v5 * v2
        };
        if (v2 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v5) {
            return v3
        };
        let v6 = v5 * v2;
        let v7 = v6;
        if (v6 > v3) {
            v7 = v3;
        };
        v7
    }

    public fun median_to_max(arg0: u256, arg1: u256) : u256 {
        if (arg1 > arg0) {
            return arg1 - (arg1 - arg0) / 33
        };
        if (arg1 < arg0) {
            return arg1 + (arg0 - arg1) / 33
        };
        arg1
    }

    fun u256_div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            1 + (arg0 - 1) / arg1
        }
    }

    fun u256_mul_div_down(arg0: u256, arg1: u256, arg2: u256) : u256 {
        arg0 * arg1 / arg2
    }

    fun u256_mul_div_up(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = if (arg0 * arg1 % arg2 > 0) {
            1
        } else {
            0
        };
        u256_mul_div_down(arg0, arg1, arg2) + v0
    }

    public fun u256_pow(arg0: u256, arg1: u8) : u256 {
        if (arg1 == 0) {
            1
        } else {
            let v1 = 1;
            while (arg1 > 1) {
                if (arg1 % 2 == 1) {
                    v1 = v1 * arg0;
                };
                arg1 = arg1 / 2;
                arg0 = arg0 * arg0;
            };
            v1 * arg0
        }
    }

    public fun u256_try_divide_and_round_up(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        } else {
            (true, u256_div_up(arg0, arg1))
        }
    }

    fun u256_try_mul(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            return (true, 0)
        };
        if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            (false, 0)
        } else {
            (true, arg0 * arg1)
        }
    }

    public fun u256_try_mul_div_down(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg1 == arg2) {
            return arg0
        };
        if (arg0 == arg2) {
            return arg1
        };
        let v0 = arg0 / arg2;
        let v1 = arg0 % arg2;
        let v2 = arg1 / arg2;
        let v3 = arg1 % arg2;
        v0 * v2 * arg2 + v0 * v3 + v1 * v2 + v1 * v3 / arg2
    }

    public fun u256_try_mul_div_up(arg0: u256, arg1: u256, arg2: u256) : (bool, u256) {
        if (arg2 == 0) {
            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        };
        let (v0, _) = u256_try_mul(arg0, arg1);
        if (!v0) {
            return (false, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        };
        (true, u256_mul_div_up(arg0, arg1, arg2))
    }

    public fun vector_to_u256(arg0: vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = v0 * 256;
            v0 = v2 + (*0x1::vector::borrow<u8>(&arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

