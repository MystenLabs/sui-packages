module 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::uint256x256_math {
    public fun mul_div_round_down(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 202);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            return arg0 * arg1 / arg2
        };
        let v0 = arg0 / arg2;
        let v1 = arg0 % arg2;
        if (v0 > 0 && arg1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v0) {
            abort 200
        };
        if (v1 > 0) {
            if (arg1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v1) {
                v0 * arg1 + v1 * (arg1 & 340282366920938463463374607431768211455) / arg2 + mul_div_round_down_internal(v1 * (arg1 >> 128), 340282366920938463463374607431768211456, arg2)
            } else {
                v0 * arg1 + v1 * arg1 / arg2
            }
        } else {
            v0 * arg1
        }
    }

    fun mul_div_round_down_internal(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            arg0 * arg1 / arg2
        } else {
            let v1 = mul_div_round_down_internal(arg0, arg1 >> 1, arg2);
            let v2 = if (arg1 & 1 == 1) {
                arg0 / arg2
            } else {
                0
            };
            v1 + v1 + v2
        }
    }

    public fun mul_div_round_up(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return mul_div_round_down(arg0, arg1, arg2)
        };
        let v0 = if (arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            arg0 * arg1 % arg2
        } else {
            let v1 = arg0 % arg2;
            if (v1 > 0 && arg1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v1) {
                v1 * arg1 % arg2
            } else {
                1
            }
        };
        if (v0 > 0) {
            mul_div_round_down(arg0, arg1, arg2) + 1
        } else {
            mul_div_round_down(arg0, arg1, arg2)
        }
    }

    public fun mul_shift_round_down(arg0: u256, arg1: u256, arg2: u8) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg2 == 255) {
            if (arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
                return 1
            };
            return arg0 * arg1 >> 255
        };
        if (arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            return arg0 * arg1 >> arg2
        };
        let v0 = arg0 >> 128;
        let v1 = arg0 & 340282366920938463463374607431768211455;
        let v2 = arg1 >> 128;
        let v3 = arg1 & 340282366920938463463374607431768211455;
        let v4 = v0 * v2;
        if (v4 > 0) {
            if (arg2 == 0 || v4 >= 1 << arg2) {
                abort 201
            };
        };
        if (arg2 >= 128) {
            let v6 = arg2 - 128;
            (v4 << 128 - v6) + (v0 * v3 + v1 * v2 >> v6)
        } else {
            (v0 * v3 + v1 * v2 << 128 - arg2) + (v1 * v3 >> arg2)
        }
    }

    public fun mul_shift_round_up(arg0: u256, arg1: u256, arg2: u8) : u256 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return mul_shift_round_down(arg0, arg1, arg2)
        };
        let v1 = if (arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            arg0 * arg1 & (1 << arg2) - 1
        } else {
            1
        };
        if (v1 > 0) {
            mul_shift_round_down(arg0, arg1, arg2) + 1
        } else {
            mul_shift_round_down(arg0, arg1, arg2)
        }
    }

    public fun shift_div_round_down(arg0: u256, arg1: u8, arg2: u256) : u256 {
        assert!(arg2 != 0, 202);
        if (arg0 == 0) {
            return 0
        };
        if (arg1 > 0 && arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 >> arg1) {
            let v1 = arg0 / arg2;
            let v2 = arg0 % arg2;
            if (v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 >> arg1) {
                abort 201
            };
            if (v2 > 0) {
                if (v2 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 >> arg1) {
                    (v1 << arg1) + (v2 << arg1) / arg2
                } else {
                    (v1 << arg1) + mul_div_round_down(v2, 1 << arg1, arg2)
                }
            } else {
                v1 << arg1
            }
        } else {
            (arg0 << arg1) / arg2
        }
    }

    public fun shift_div_round_up(arg0: u256, arg1: u8, arg2: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg1 > 0 && arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 >> arg1) {
            1
        } else {
            (arg0 << arg1) % arg2
        };
        if (v0 > 0) {
            shift_div_round_down(arg0, arg1, arg2) + 1
        } else {
            shift_div_round_down(arg0, arg1, arg2)
        }
    }

    public fun sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 <= 3) {
            return 1
        };
        let v0 = 1 << (0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::bit_math::most_significant_bit(arg0) >> 1) + 1;
        loop {
            let v1 = v0 + arg0 / v0 >> 1;
            if (v1 >= v0) {
                break
            };
            v0 = v1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

