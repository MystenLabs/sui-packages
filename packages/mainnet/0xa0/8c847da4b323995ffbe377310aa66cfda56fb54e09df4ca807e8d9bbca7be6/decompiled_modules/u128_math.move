module 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::u128_math {
    public fun mul_shr(arg0: u128, arg1: u128, arg2: u8) : u128 {
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_shr(arg0, arg1, arg2, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u128>(&v0)) {
            return 0x1::option::destroy_some<u128>(v0)
        } else {
            0x1::option::destroy_none<u128>(v0);
            abort 2
        };
    }

    public fun ceil_div(arg0: u128, arg1: u128) : u128 {
        assert!(arg1 != 0, 1);
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun checked_add(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 as u256) + (arg1 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 2);
        (v0 as u128)
    }

    public fun checked_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 2);
        arg0 + arg1
    }

    public fun checked_mul(arg0: u128, arg1: u128) : u128 {
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(arg0, arg1, 1, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u128>(&v0)) {
            return 0x1::option::destroy_some<u128>(v0)
        } else {
            0x1::option::destroy_none<u128>(v0);
            abort 2
        };
    }

    public fun fits_u64(arg0: u128) : bool {
        arg0 <= 18446744073709551615
    }

    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_u128() : u128 {
        (340282366920938463463374607431768211455 as u128)
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun max_u64_as_u128() : u128 {
        18446744073709551615
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun msb(arg0: u128) : u8 {
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >= 18446744073709551616) {
            v1 = v0 + 64;
            v2 = arg0 >> 64;
        };
        if (v2 >= 4294967296) {
            v1 = v1 + 32;
            v2 = v2 >> 32;
        };
        if (v2 >= 65536) {
            v1 = v1 + 16;
            v2 = v2 >> 16;
        };
        if (v2 >= 256) {
            v1 = v1 + 8;
            v2 = v2 >> 8;
        };
        if (v2 >= 16) {
            v1 = v1 + 4;
            v2 = v2 >> 4;
        };
        if (v2 >= 4) {
            v1 = v1 + 2;
            v2 = v2 >> 2;
        };
        if (v2 >= 2) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun mul_div_ceil(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(arg0, arg1, arg2, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up());
        if (0x1::option::is_some<u128>(&v0)) {
            return 0x1::option::destroy_some<u128>(v0)
        } else {
            0x1::option::destroy_none<u128>(v0);
            abort 2
        };
    }

    public fun mul_div_floor(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(arg0, arg1, arg2, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u128>(&v0)) {
            return 0x1::option::destroy_some<u128>(v0)
        } else {
            0x1::option::destroy_none<u128>(v0);
            abort 2
        };
    }

    public fun mul_div_nearest(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(arg0, arg1, arg2, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::nearest());
        if (0x1::option::is_some<u128>(&v0)) {
            return 0x1::option::destroy_some<u128>(v0)
        } else {
            0x1::option::destroy_none<u128>(v0);
            abort 2
        };
    }

    public fun mul_shr_ceil(arg0: u128, arg1: u128, arg2: u8) : u128 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        let v1 = v0 >> arg2;
        let v2 = if (v1 << arg2 < v0) {
            v1 + 1
        } else {
            v1
        };
        assert!(v2 <= 340282366920938463463374607431768211455, 2);
        (v2 as u128)
    }

    public fun pow10(arg0: u8) : u128 {
        assert!(arg0 <= 38, 2);
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun q64() : u128 {
        18446744073709551616
    }

    public fun saturating_add(arg0: u128, arg1: u128) : u128 {
        let v0 = max_u128();
        if (arg1 > v0 - arg0) {
            v0
        } else {
            arg0 + arg1
        }
    }

    public fun saturating_add_u64(arg0: u64, arg1: u64) : u64 {
        if (arg1 > 18446744073709551615 - arg0) {
            18446744073709551615
        } else {
            arg0 + arg1
        }
    }

    public fun saturating_sub_u64(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun shl_div(arg0: u128, arg1: u8, arg2: u128) : u128 {
        assert!(arg2 != 0, 1);
        assert!(arg1 < 128, 2);
        let v0 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(arg0, 1 << arg1, arg2, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
        if (0x1::option::is_some<u128>(&v0)) {
            return 0x1::option::destroy_some<u128>(v0)
        } else {
            0x1::option::destroy_none<u128>(v0);
            abort 2
        };
    }

    // decompiled from Move bytecode v7
}

