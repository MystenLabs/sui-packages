module 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::math_ext {
    public fun is_spike_violation(arg0: u128, arg1: u128, arg2: u64, arg3: u64) : bool {
        (arg0 as u256) * (31536000000 as u256) * (1000000000 as u256) > 0x1::option::destroy_some<u256>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u256::mul_div((arg1 as u256) * (arg2 as u256), (arg3 as u256), 1, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()))
    }

    public fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div_down_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_div_by_zero());
        0x1::option::destroy_some<u128>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(arg0, arg1, arg2, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()))
    }

    public fun mul_div_down_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_div_by_zero());
        let v0 = 0x1::option::destroy_some<u128>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()));
        assert!(v0 <= 18446744073709551615, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_overflow());
        (v0 as u64)
    }

    public fun mul_div_up_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_div_by_zero());
        0x1::option::destroy_some<u128>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div(arg0, arg1, arg2, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up()))
    }

    public fun mul_div_up_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_div_by_zero());
        let v0 = 0x1::option::destroy_some<u128>(0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128), 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::up()));
        assert!(v0 <= 18446744073709551615, 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::errors::e_overflow());
        (v0 as u64)
    }

    public fun rate_scale() : u128 {
        1000000000
    }

    public fun year_ms() : u64 {
        31536000000
    }

    // decompiled from Move bytecode v7
}

