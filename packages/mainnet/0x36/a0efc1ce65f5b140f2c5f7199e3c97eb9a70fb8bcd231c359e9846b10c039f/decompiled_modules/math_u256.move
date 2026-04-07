module 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256 {
    public fun overflowing_add(arg0: u256, arg1: u256) : (u256, bool) {
        let (v0, v1) = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u128::overflowing_add(((arg0 & 340282366920938463463374607431768211455) as u128), ((arg1 & 340282366920938463463374607431768211455) as u128));
        let (v2, v3) = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u128::overflowing_add(((arg0 >> 128 & 340282366920938463463374607431768211455) as u128), ((arg1 >> 128 & 340282366920938463463374607431768211455) as u128));
        let v4 = if (v1) {
            1
        } else {
            0
        };
        let (v5, v6) = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u128::overflowing_add(v2, v4);
        let v7 = v3 || v6;
        ((v5 as u256) << 128 | (v0 as u256), v7)
    }

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
        let v0 = arg0 / arg1;
        if (arg2 && v0 * arg1 != arg0) {
            v0 + 1
        } else {
            v0
        }
    }

    public fun overflowing_sub(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg0 >= arg1) {
            (arg0 - arg1, false)
        } else {
            (115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1 + arg0 + 1, true)
        }
    }

    public fun shlw(arg0: u256) : u256 {
        arg0 << 64
    }

    public fun shrw(arg0: u256) : u256 {
        arg0 >> 64
    }

    public fun wrapping_add(arg0: u256, arg1: u256) : u256 {
        let (v0, _) = overflowing_add(arg0, arg1);
        v0
    }

    public fun wrapping_sub(arg0: u256, arg1: u256) : u256 {
        let (v0, _) = overflowing_sub(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

