module 0xb2186aaf415c610c24d623665876024ca56892f9524066ccac802f4ae81473b9::utils {
    public fun div_down(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun mul_div_down(arg0: u256, arg1: u256, arg2: u256) : u256 {
        arg0 * arg1 / arg2
    }

    public fun try_div_down(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, div_down(arg0, arg1))
        }
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

    public fun try_mul_div_down(arg0: u64, arg1: u64, arg2: u64) : (bool, u64) {
        let (v0, v1) = try_mul_div_down_256((arg0 as u256), (arg1 as u256), (arg2 as u256));
        if (!v0 || v1 > 18446744073709551615) {
            (false, 0)
        } else {
            (true, (v1 as u64))
        }
    }

    public fun try_mul_div_down_256(arg0: u256, arg1: u256, arg2: u256) : (bool, u256) {
        if (arg2 == 0) {
            return (false, 0)
        };
        let (v0, _) = try_mul(arg0, arg1);
        if (!v0) {
            return (false, 0)
        };
        (true, mul_div_down(arg0, arg1, arg2))
    }

    // decompiled from Move bytecode v6
}

