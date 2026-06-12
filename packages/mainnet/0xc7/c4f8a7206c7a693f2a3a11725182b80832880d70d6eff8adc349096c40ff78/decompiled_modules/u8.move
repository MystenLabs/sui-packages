module 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u8 {
    public fun clz(arg0: u8) : u8 {
        (0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::common::clz((arg0 as u256), (8 as u16)) as u8)
    }

    public fun msb(arg0: u8) : u8 {
        0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::common::msb((arg0 as u256), (8 as u16))
    }

    public fun average(arg0: u8, arg1: u8, arg2: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : u8 {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        if (v0 == v1) {
            (v0 as u8)
        } else {
            let v3 = v0;
            let v4 = v1;
            if (v0 > v1) {
                v3 = v1;
                v4 = v0;
            };
            let (_, v6) = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::mul_div_u256_fast(v4 - v3, 1, 2, arg2);
            ((v3 + v6) as u8)
        }
    }

    public fun checked_shl(arg0: u8, arg1: u8) : 0x1::option::Option<u8> {
        if (arg0 == 0) {
            0x1::option::some<u8>(0)
        } else if (arg1 >= 8) {
            0x1::option::none<u8>()
        } else if (arg1 == 0) {
            0x1::option::some<u8>(arg0)
        } else {
            let v1 = arg0 << arg1;
            if (v1 >> arg1 != arg0) {
                0x1::option::none<u8>()
            } else {
                0x1::option::some<u8>(v1)
            }
        }
    }

    public fun checked_shr(arg0: u8, arg1: u8) : 0x1::option::Option<u8> {
        if (arg0 == 0) {
            0x1::option::some<u8>(0)
        } else if (arg1 >= 8) {
            0x1::option::none<u8>()
        } else if (arg0 & (((1 << arg1) - 1) as u8) != 0) {
            0x1::option::none<u8>()
        } else {
            0x1::option::some<u8>(arg0 >> arg1)
        }
    }

    public fun inv_mod(arg0: u8, arg1: u8) : 0x1::option::Option<u8> {
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::inv_mod_extended_impl((arg0 as u256), (arg1 as u256));
        if (0x1::option::is_some<u256>(&v0)) {
            0x1::option::some<u8>((0x1::option::destroy_some<u256>(v0) as u8))
        } else {
            0x1::option::destroy_none<u256>(v0);
            0x1::option::none<u8>()
        }
    }

    public fun is_power_of_ten(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 10) {
            true
        } else {
            arg0 == 100
        }
    }

    public fun log10(arg0: u8, arg1: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : u8 {
        let v0 = (arg0 as u256);
        if (v0 == 0) {
            0
        } else {
            let v2 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::log10_floor(v0);
            if (arg1 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()) {
                v2
            } else if (v0 == 0x1::u256::pow(10, v2)) {
                v2
            } else if (arg1 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up()) {
                v2 + 1
            } else {
                0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::round_log10_to_nearest(v0, v2)
            }
        }
    }

    public fun log2(arg0: u8, arg1: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : u8 {
        let v0 = (arg0 as u256);
        let v1 = if (v0 == 0) {
            0
        } else {
            let v2 = (0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::common::msb(v0, (8 as u16)) as u16);
            if (arg1 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()) {
                v2
            } else if (v0 == 1 << (v2 as u8)) {
                v2
            } else if (arg1 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up()) {
                v2 + 1
            } else {
                0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::round_log2_to_nearest(v0, v2)
            }
        };
        (v1 as u8)
    }

    public fun log256(arg0: u8, arg1: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : u8 {
        let v0 = (arg0 as u256);
        if (v0 == 0) {
            0
        } else {
            let v2 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::common::msb(v0, (8 as u16));
            if (arg1 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()) {
                v2 / 8
            } else if (v2 % 8 == 0 && v0 == 1 << (v2 as u8)) {
                v2 / 8
            } else if (arg1 == 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up()) {
                v2 / 8 + 1
            } else {
                0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::round_log256_to_nearest(v0, v2 / 8)
            }
        }
    }

    public fun mul_div(arg0: u8, arg1: u8, arg2: u8, arg3: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : 0x1::option::Option<u8> {
        let (_, v1) = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::mul_div_inner((arg0 as u256), (arg1 as u256), (arg2 as u256), arg3);
        0x1::u256::try_as_u8(v1)
    }

    public fun mul_mod(arg0: u8, arg1: u8, arg2: u8) : u8 {
        (0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::mul_mod_impl((arg0 as u256), (arg1 as u256), (arg2 as u256)) as u8)
    }

    public fun mul_shr(arg0: u8, arg1: u8, arg2: u8, arg3: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : 0x1::option::Option<u8> {
        let (_, v1) = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::mul_shr_inner((arg0 as u256), (arg1 as u256), arg2, arg3);
        0x1::u256::try_as_u8(v1)
    }

    public fun sqrt(arg0: u8, arg1: 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::RoundingMode) : u8 {
        let v0 = (arg0 as u256);
        (0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::macros::round_sqrt_result(v0, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::common::sqrt_floor(v0), arg1) as u8)
    }

    // decompiled from Move bytecode v7
}

