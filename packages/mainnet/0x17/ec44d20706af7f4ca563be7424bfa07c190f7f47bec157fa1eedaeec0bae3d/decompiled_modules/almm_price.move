module 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_price {
    public fun convert_128x128_price_to_decimal(arg0: u256) : u256 {
        arg0 * (0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::precision() as u256) >> 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::scale_offset()
    }

    public fun convert_decimal_price_to_128x128(arg0: u256) : u256 {
        0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::u128x128::to_u128x128(0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe128(arg0), 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::precision_n())
    }

    fun get_base(arg0: u16) : u256 {
        0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::scale() + ((arg0 as u256) << 0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::scale_offset()) / (0x17ec44d20706af7f4ca563be7424bfa07c190f7f47bec157fa1eedaeec0bae3d::almm_constants::basis_point_max() as u256)
    }

    fun get_exponent(arg0: u32) : 0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::I32 {
        get_real_id(arg0)
    }

    public fun get_price_from_storage_id(arg0: u32, arg1: u16) : u256 {
        0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::u128x128::pow(get_base(arg1), get_exponent(arg0))
    }

    public fun get_real_id(arg0: u32) : 0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::I32 {
        assert!(arg0 < 8388608 << 1, 1);
        if (arg0 >= 8388608) {
            0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::from(arg0 - 8388608)
        } else {
            0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::neg_from(8388608 - arg0)
        }
    }

    public fun get_real_id_from_price(arg0: u256, arg1: u16) : 0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::I32 {
        let (v0, v1) = 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::u128x128::log2(arg0);
        let (v2, v3) = 0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::u128x128::log2(get_base(arg1));
        if (v1 != v3) {
            0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::neg_from(0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe32(v0 / v2))
        } else {
            0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::from(0xf2565732e0fe45f224e3f0d17914960ac0e36d2470dceb5d09e77d72473ebbdc::uint_safe::safe32(v0 / v2))
        }
    }

    public fun get_storage_id_from_real_id(arg0: 0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::I32) : u32 {
        if (0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::gte(arg0, 0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::zero())) {
            0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::as_u32(arg0) + 8388608
        } else {
            8388608 - 0xec2104ea911f9583a68ed634183831609ffb7274e7e46ba1d491e10dd5423495::i32::abs_u32(arg0)
        }
    }

    // decompiled from Move bytecode v6
}

