module 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full128 {
    public fun abs_diff(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun average(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg0 + (arg1 - arg0 >> 1)
        } else {
            arg1 + (arg0 - arg1 >> 1)
        }
    }

    public fun average_up(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg1 - (arg1 - arg0 >> 1)
        } else {
            arg0 - (arg0 - arg1 >> 1)
        }
    }

    public fun clamp(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg1 <= arg2, 4);
        if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        }
    }

    public fun div_up(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 != 0, 1);
        if (arg0 % arg1 != 0) {
            arg0 / arg1 + 1
        } else {
            arg0 / arg1
        }
    }

    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div_down(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 2);
        (v0 as u128)
    }

    public fun mul_div_up(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = (arg2 as u256);
        let v2 = if (v0 % v1 != 0) {
            v0 / v1 + 1
        } else {
            v0 / v1
        };
        assert!(v2 <= 340282366920938463463374607431768211455, 2);
        (v2 as u128)
    }

    public fun mul_shr_down(arg0: u128, arg1: u128, arg2: u8) : u128 {
        if (arg2 > 255) {
            0
        } else {
            let v1 = (arg0 as u256) * (arg1 as u256) >> arg2;
            assert!(v1 <= 340282366920938463463374607431768211455, 2);
            (v1 as u128)
        }
    }

    public fun mul_shr_up(arg0: u128, arg1: u128, arg2: u8) : u128 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        if (arg2 > 255) {
            if (v0 == 0) {
                0
            } else {
                1
            }
        } else {
            let v2 = v0 >> arg2;
            let v3 = if (v2 << arg2 != v0) {
                v2 + 1
            } else {
                v2
            };
            assert!(v3 <= 340282366920938463463374607431768211455, 2);
            (v3 as u128)
        }
    }

    public fun mul_wide(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    public fun saturating_add(arg0: u128, arg1: u128) : u128 {
        if (arg0 > 340282366920938463463374607431768211455 - arg1) {
            340282366920938463463374607431768211455
        } else {
            arg0 + arg1
        }
    }

    public fun saturating_mul(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        if (v0 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v0 as u128)
        }
    }

    public fun saturating_sub(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun shl_checked(arg0: u128, arg1: u8) : u128 {
        if (arg1 > 127) {
            assert!(arg0 == 0, 3);
            0
        } else {
            assert!(arg0 <= 340282366920938463463374607431768211455 >> arg1, 3);
            arg0 << arg1
        }
    }

    public fun wrapping_add(arg0: u128, arg1: u128) : u128 {
        let v0 = 340282366920938463463374607431768211455 - arg1;
        if (arg0 > v0) {
            arg0 - v0 - 1
        } else {
            arg0 + arg1
        }
    }

    public fun wrapping_mul(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) % 340282366920938463463374607431768211456) as u128)
    }

    public fun wrapping_sub(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            340282366920938463463374607431768211455 - arg1 - arg0 + 1
        }
    }

    // decompiled from Move bytecode v7
}

