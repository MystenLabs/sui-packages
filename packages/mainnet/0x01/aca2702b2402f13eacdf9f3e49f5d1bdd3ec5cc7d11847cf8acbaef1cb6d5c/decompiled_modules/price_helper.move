module 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::price_helper {
    public fun get_base(arg0: u16) : u128 {
        assert!(arg0 > 0, 602);
        let v0 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::q64x64::scale();
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::add_u128(v0, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::q64x64::mul_div_round_down_u128((arg0 as u128), v0, (0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::constants::basis_point_max() as u128)))
    }

    public fun get_exponent(arg0: u32) : u128 {
        assert!(arg0 >= 7340033 && arg0 <= 9437183, 601);
        let v0 = (arg0 as u128);
        let v1 = (8388608 as u128);
        if (v0 >= v1) {
            v0 - v1
        } else {
            340282366920938463463374607431768211455 - v1 - v0 + 1
        }
    }

    public fun get_id_for_price_one() : u32 {
        8388608
    }

    public fun get_id_from_price(arg0: u128, arg1: u16) : u32 {
        assert!(arg0 > 0, 600);
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::validate_bin_step(arg1);
        if (arg0 < 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::q64x64::scale() >> 40) {
            return 7340033
        };
        let v0 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::q64x64::log2(get_base(arg1));
        let v1 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::q64x64::log2(arg0);
        let v2 = v1 > 170141183460469231731687303715884105727;
        let v3 = v0 > 170141183460469231731687303715884105727;
        let v4 = if (v2) {
            340282366920938463463374607431768211455 - v1 + 1
        } else {
            v1
        };
        let v5 = if (v3) {
            340282366920938463463374607431768211455 - v0 + 1
        } else {
            v0
        };
        let v6 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::q64x64::div(v4, v5) >> 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::q64x64::scale_offset();
        let v7 = if (!(v2 != v3)) {
            let v8 = (8388608 as u128) + v6;
            assert!(v8 <= (9437183 as u128), 601);
            0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::u128_to_u32(v8)
        } else {
            assert!(v6 <= (8388608 as u128) - (7340033 as u128), 601);
            0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::safe_math::u128_to_u32((8388608 as u128) - v6)
        };
        assert!(v7 >= 7340033 && v7 <= 9437183, 601);
        v7
    }

    public fun get_price_from_id(arg0: u32, arg1: u16) : u128 {
        validate_bin_id(arg0);
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::validate_bin_step(arg1);
        0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::q64x64::pow(get_base(arg1), get_exponent(arg0))
    }

    public fun get_valid_id_range() : (u32, u32) {
        (7340033, 9437183)
    }

    public fun is_valid_id(arg0: u32) : bool {
        arg0 >= 7340033 && arg0 <= 9437183
    }

    public fun validate_bin_id(arg0: u32) {
        assert!(arg0 >= 7340033 && arg0 <= 9437183, 601);
    }

    // decompiled from Move bytecode v6
}

