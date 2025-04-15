module 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_price {
    public fun convert_128x128_price_to_decimal(arg0: u256) : u256 {
        arg0 * (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::precision() as u256) >> 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::scale_offset()
    }

    public fun convert_decimal_price_to_128x128(arg0: u256) : u256 {
        0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::u128x128::to_u128x128(0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe128(arg0), 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::precision_n())
    }

    fun get_base(arg0: u16) : u256 {
        0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::scale() + ((arg0 as u256) << 0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::scale_offset()) / (0xf676f63a36cd3e721ed3863798b0199433ddbf3192c762f6a555b06ba3f62ae9::dlmm_constants::basis_point_max() as u256)
    }

    fun get_exponent(arg0: u32) : 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::I32 {
        get_real_id(arg0)
    }

    public fun get_price_from_storage_id(arg0: u32, arg1: u16) : u256 {
        0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::u128x128::pow(get_base(arg1), get_exponent(arg0))
    }

    public fun get_real_id(arg0: u32) : 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::I32 {
        assert!(arg0 < 8388608 << 1, 1);
        if (arg0 >= 8388608) {
            0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::from(arg0 - 8388608)
        } else {
            0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::neg_from(8388608 - arg0)
        }
    }

    public fun get_real_id_from_price(arg0: u256, arg1: u16) : 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::I32 {
        let (v0, v1) = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::u128x128::log2(arg0);
        let (v2, v3) = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::u128x128::log2(get_base(arg1));
        if (v1 != v3) {
            0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::neg_from(0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe32(v0 / v2))
        } else {
            0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::from(0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::uint_safe::safe32(v0 / v2))
        }
    }

    public fun get_storage_id_from_real_id(arg0: 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::I32) : u32 {
        if (0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::gte(arg0, 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::zero())) {
            0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::as_u32(arg0) + 8388608
        } else {
            8388608 - 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::abs_u32(arg0)
        }
    }

    // decompiled from Move bytecode v6
}

