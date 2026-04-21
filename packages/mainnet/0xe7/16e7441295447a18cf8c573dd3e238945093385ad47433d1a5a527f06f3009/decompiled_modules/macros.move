module 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros {
    public(friend) fun inv_mod_extended_impl(arg0: u256, arg1: u256) : 0x1::option::Option<u256> {
        assert!(arg1 != 0, 13835343520283623427);
        if (arg1 == 1) {
            return 0x1::option::none<u256>()
        };
        let v0 = arg0 % arg1;
        if (v0 == 0) {
            return 0x1::option::none<u256>()
        };
        let v1 = arg1;
        let v2 = 0;
        let v3 = v2;
        let v4 = 1;
        while (v0 != 0) {
            let v5 = v1 / v0;
            let v6 = v4;
            let v7 = mul_mod_impl(v5, v4, arg1);
            v4 = mod_sub_impl(v2, v7, arg1);
            v3 = v6;
            let v8 = v0;
            let v9 = v5 * v0;
            v0 = arg1 - v9;
            v1 = v8;
        };
        if (v1 != 1) {
            0x1::option::none<u256>()
        } else {
            0x1::option::some<u256>(v3)
        }
    }

    public(friend) fun log10_floor(arg0: u256) : u8 {
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        if (arg0 >= 10000000000000000000000000000000000000000000000000000000000000000) {
            v0 = arg0 / 10000000000000000000000000000000000000000000000000000000000000000;
            v2 = v1 + 64;
        };
        if (v0 >= 100000000000000000000000000000000) {
            v0 = v0 / 100000000000000000000000000000000;
            v2 = v2 + 32;
        };
        if (v0 >= 10000000000000000) {
            v0 = v0 / 10000000000000000;
            v2 = v2 + 16;
        };
        if (v0 >= 100000000) {
            v0 = v0 / 100000000;
            v2 = v2 + 8;
        };
        if (v0 >= 10000) {
            v0 = v0 / 10000;
            v2 = v2 + 4;
        };
        if (v0 >= 100) {
            v0 = v0 / 100;
            v2 = v2 + 2;
        };
        if (v0 >= 10) {
            v2 = v2 + 1;
        };
        v2
    }

    public(friend) fun mod_sub_impl(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            arg2 - arg1 - arg0
        }
    }

    public(friend) fun mul_div_inner(arg0: u256, arg1: u256, arg2: u256, arg3: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : (bool, u256) {
        let v0 = 340282366920938463463374607431768211455;
        if (arg0 > v0 || arg1 > v0) {
            mul_div_u256_wide(arg0, arg1, arg2, arg3)
        } else {
            mul_div_u256_fast(arg0, arg1, arg2, arg3)
        }
    }

    public(friend) fun mul_div_u256_fast(arg0: u256, arg1: u256, arg2: u256, arg3: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : (bool, u256) {
        assert!(arg2 != 0, 13835060172701040641);
        let v0 = arg0 * arg1;
        let v1 = v0 / arg2;
        let v2 = v1;
        let v3 = v0 % arg2;
        if (v3 != 0) {
            let (_, v5) = round_division_result(v1, arg2, v3, arg3);
            v2 = v5;
        };
        (false, v2)
    }

    public(friend) fun mul_div_u256_wide(arg0: u256, arg1: u256, arg2: u256, arg3: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : (bool, u256) {
        assert!(arg2 != 0, 13835060340204765185);
        let (v0, v1, v2) = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::div_rem_u256(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::mul_u256(arg0, arg1), arg2);
        if (v0) {
            (true, 0)
        } else if (v2 == 0) {
            (false, v1)
        } else {
            round_division_result(v1, arg2, v2, arg3)
        }
    }

    public(friend) fun mul_mod_impl(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 != 0, 13835343816636366851);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 340282366920938463463374607431768211455;
        if (arg0 > v0 || arg1 > v0) {
            let (_, _, v4) = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::div_rem_u256(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::mul_u256(arg0, arg1), arg2);
            v4
        } else {
            arg0 * arg1 % arg2
        }
    }

    public(friend) fun mul_shr_inner(arg0: u256, arg1: u256, arg2: u8, arg3: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : (bool, u256) {
        let v0 = 340282366920938463463374607431768211455;
        if (arg0 > v0 || arg1 > v0) {
            mul_shr_u256_wide(arg0, arg1, arg2, arg3)
        } else {
            mul_shr_u256_fast(arg0, arg1, arg2, arg3)
        }
    }

    public(friend) fun mul_shr_u256_fast(arg0: u256, arg1: u256, arg2: u8, arg3: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : (bool, u256) {
        let v0 = arg0 * arg1;
        if (arg2 == 0) {
            return (false, v0)
        };
        let v1 = v0 >> arg2;
        let v2 = v1;
        let v3 = 1 << arg2;
        let v4 = v0 & v3 - 1;
        if (v4 != 0) {
            let (_, v6) = round_division_result(v1, v3, v4, arg3);
            v2 = v6;
        };
        (false, v2)
    }

    public(friend) fun mul_shr_u256_wide(arg0: u256, arg1: u256, arg2: u8, arg3: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : (bool, u256) {
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::mul_u256(arg0, arg1);
        let v1 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::hi(&v0);
        let v2 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::lo(&v0);
        if (arg2 == 0) {
            if (v1 != 0) {
                return (true, 0)
            };
            return (false, v2)
        };
        if (v1 >> arg2 != 0) {
            return (true, 0)
        };
        let v3 = v2 >> arg2 | v1 << ((256 - (arg2 as u16)) as u8);
        let v4 = v3;
        let v5 = v2 & (1 << arg2) - 1;
        if (v5 != 0) {
            let (v6, v7) = round_division_result(v3, 1 << arg2, v5, arg3);
            if (v6) {
                return (true, 0)
            };
            v4 = v7;
        };
        (false, v4)
    }

    public(friend) fun round_division_result(arg0: u256, arg1: u256, arg2: u256, arg3: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : (bool, u256) {
        let v0 = arg3 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up() || arg3 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::nearest() && arg2 >= arg1 - arg2;
        if (!v0) {
            (false, arg0)
        } else if (arg0 == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
            (true, 0)
        } else {
            (false, arg0 + 1)
        }
    }

    public(friend) fun round_log10_to_nearest(arg0: u256, arg1: u8) : u8 {
        if (arg1 >= 77) {
            return arg1
        };
        let v0 = if (arg1 <= 38 && arg0 <= 340282366920938463463374607431768211455) {
            arg0 * arg0 >= 0x1::u256::pow(10, 2 * arg1 + 1)
        } else {
            let v1 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::mul_u256(arg0, arg0);
            let v2 = 0x1::u256::pow(10, arg1);
            let v3 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::mul_u256(10 * v2, v2);
            0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::ge(&v1, &v3)
        };
        if (v0) {
            arg1 + 1
        } else {
            arg1
        }
    }

    public(friend) fun round_log256_to_nearest(arg0: u256, arg1: u8) : u8 {
        if (arg0 >= 1 << 8 * arg1 + 4) {
            arg1 + 1
        } else {
            arg1
        }
    }

    public(friend) fun round_log2_to_nearest(arg0: u256, arg1: u16) : u16 {
        let v0 = 2 * arg1 + 1;
        let v1 = if (v0 < 256 && arg0 <= 340282366920938463463374607431768211455) {
            arg0 * arg0 >= 1 << (v0 as u8)
        } else {
            let v2 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::mul_u256(arg0, arg0);
            let v3 = if (v0 >= 256) {
                0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::new(1 << ((v0 - 256) as u8), 0)
            } else {
                0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::from_u256(1 << (v0 as u8))
            };
            let v4 = v3;
            0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512::ge(&v2, &v4)
        };
        if (v1) {
            arg1 + 1
        } else {
            arg1
        }
    }

    public(friend) fun round_sqrt_result(arg0: u256, arg1: u256, arg2: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : u256 {
        if (arg2 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()) {
            return arg1
        };
        let v0 = arg1 * arg1;
        if (v0 == arg0) {
            arg1
        } else if (arg2 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up()) {
            arg1 + 1
        } else if (arg0 - v0 <= arg1) {
            arg1
        } else {
            arg1 + 1
        }
    }

    // decompiled from Move bytecode v7
}

