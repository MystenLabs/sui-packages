module 0x689424ca7088eb902d86507df1906f8a0ddfba2949d024c6b8e2c8801d904d03::perps_pad {
    struct PerpsVenue has drop {
        dummy_field: bool,
    }

    public fun assert_venue_pool(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        assert!(arg0 == arg1, 1);
    }

    public fun bcs_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= arg1 + 8, 0);
        let v0 = 0;
        let v1 = 1;
        let v2 = 0;
        while (v2 < 8) {
            v0 = v0 + (*0x1::vector::borrow<u8>(arg0, arg1 + v2) as u64) * v1;
            if (v2 < 7) {
                v1 = v1 * 256;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun curve_depth(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 == 0 && arg2 == 0) {
            (arg0 as u256)
        } else if (arg2 == 0) {
            (arg1 as u256)
        } else {
            ((arg1 as u256) + (arg2 as u256)) * (arg0 as u256) / (arg2 as u256)
        };
        assert!(v0 > 0 && v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    public fun depth_price(arg0: u64, arg1: u64, arg2: u8) : u128 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 <= 18
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = (arg1 as u256) * (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::pow10(arg2) as u256) * (1000000000000 as u256) / (arg0 as u256);
        assert!(v1 <= 340282366920938463463374607431768211455, 0);
        (v1 as u128)
    }

    public fun spot_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : u128 {
        assert!(arg0 > 0 && arg4 <= 18, 0);
        let v0 = if (arg2 == 0 && arg3 == 0) {
            (arg1 as u256)
        } else if (arg3 == 0) {
            (arg2 as u256)
        } else {
            ((arg2 as u256) + (arg3 as u256)) * (arg1 as u256) / (arg3 as u256)
        };
        assert!(v0 > 0, 0);
        let v1 = v0 * (0xad6769be9937a4a818d3a8b222de9c4e99d2bc9012a2828aaf24ada1ff7e81b4::math::pow10(arg4) as u256) * (1000000000000 as u256) / (arg0 as u256);
        assert!(v1 <= 340282366920938463463374607431768211455, 0);
        (v1 as u128)
    }

    public fun usdc_depth_in_sui(arg0: u64, arg1: u128) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 0);
        let v0 = (arg0 as u256) * (arg1 as u256) * (arg1 as u256) / 340282366920938463463374607431768211456;
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    public(friend) fun witness() : PerpsVenue {
        PerpsVenue{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

