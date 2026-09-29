module 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math {
    public fun bolt_boundary(arg0: bool, arg1: u64, arg2: u128, arg3: u128, arg4: u128) : u64 {
        if (arg4 == 0) {
            return 0
        };
        let v0 = (arg1 as u128);
        if (arg0) {
            if (arg2 <= v0) {
                0
            } else {
                cap(((arg2 - v0) as u256))
            }
        } else if (v0 <= arg2) {
            0
        } else {
            cap(((v0 - arg2) as u256) * (arg3 as u256) / (arg4 as u256))
        }
    }

    public fun book_input(arg0: u64, arg1: u64) : u64 {
        ceil_div((arg0 as u256) * (1000000000 + (arg1 as u256) * 3 / 2), 1000000000)
    }

    public fun cap(arg0: u256) : u64 {
        if (arg0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (arg0 as u64)
        }
    }

    public fun ceil_div(arg0: u256, arg1: u256) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        cap(arg0 / arg1 + v0)
    }

    public fun clears(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg2 > 0) {
            if (arg0 >= arg1) {
                arg0 - arg1 >= arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun clmm_price(arg0: u128, arg1: bool) : u128 {
        if (arg0 == 0 || arg0 > 79226673515401279992447579054) {
            return 0
        };
        let v0 = if (arg1) {
            340282366920938463463374607431768211456 * 1000000000 / (arg0 as u256) * (arg0 as u256)
        } else {
            (arg0 as u256) * (arg0 as u256) * 1000000000 / 340282366920938463463374607431768211456
        };
        if (v0 > 340282366920938463463374607431768211455) {
            0
        } else {
            (v0 as u128)
        }
    }

    public fun debt_boundary(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div(arg0, arg2, arg1)
    }

    public fun live(arg0: u64, arg1: u64) : bool {
        arg0 < arg1
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        cap((arg0 as u256) * (arg1 as u256) / (arg2 as u256))
    }

    public fun round_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = arg0 / arg1 * arg1;
        if (v0 < arg2) {
            0
        } else {
            v0
        }
    }

    public fun round_up(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = ((arg0 as u256) + (arg1 as u256) - 1) / (arg1 as u256) * (arg1 as u256);
        if (v0 > 18446744073709551615) {
            0
        } else {
            (v0 as u64)
        }
    }

    public fun screen(arg0: u128, arg1: u128, arg2: u128, arg3: u64) : (bool, bool, bool) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 >= 1000000
        };
        if (v0) {
            return (false, false, false)
        };
        let v1 = (arg0 as u256);
        let v2 = (arg1 as u256);
        let v3 = (arg3 as u256);
        let v4 = arg3 == 0 || v1 * (1000000 - v3) > v2 * 1000000;
        let v5 = arg3 == 0 || (arg2 as u256) * (1000000 - v3) > v1 * 1000000;
        (v4, v5, v1 > v2)
    }

    // decompiled from Move bytecode v7
}

