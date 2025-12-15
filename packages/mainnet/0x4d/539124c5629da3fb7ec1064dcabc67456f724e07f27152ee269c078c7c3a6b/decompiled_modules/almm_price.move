module 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_price {
    public fun convert_128x128_price_to_decimal(arg0: u256) : u256 {
        arg0 * (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::precision() as u256) >> 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()
    }

    public fun convert_decimal_price_to_128x128(arg0: u256) : u256 {
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::u128x128::to_u128x128(0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe128(arg0), 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::precision_n())
    }

    fun get_base(arg0: u16) : u256 {
        0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale() + ((arg0 as u256) << 0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::scale_offset()) / (0xc7f4524aad685d7a334b559aea1a1464287a2a62d571243be1877ef53e2a916b::almm_constants::basis_point_max() as u256)
    }

    fun get_exponent(arg0: u32) : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32 {
        get_real_id(arg0)
    }

    public fun get_price_from_storage_id(arg0: u32, arg1: u16) : u256 {
        0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::u128x128::pow(get_base(arg1), get_exponent(arg0))
    }

    public fun get_real_id(arg0: u32) : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32 {
        assert!(arg0 < 8388608 << 1, 1);
        if (arg0 >= 8388608) {
            0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from(arg0 - 8388608)
        } else {
            0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::neg_from(8388608 - arg0)
        }
    }

    public fun get_real_id_from_price(arg0: u256, arg1: u16) : 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32 {
        let (v0, v1) = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::u128x128::log2(arg0);
        let (v2, v3) = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::u128x128::log2(get_base(arg1));
        if (v1 != v3) {
            0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::neg_from(0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe32(v0 / v2))
        } else {
            0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from(0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::uint_safe::safe32(v0 / v2))
        }
    }

    public fun get_storage_id_from_real_id(arg0: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32) : u32 {
        if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::gte(arg0, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::zero())) {
            0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::as_u32(arg0) + 8388608
        } else {
            8388608 - 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::abs_u32(arg0)
        }
    }

    // decompiled from Move bytecode v6
}

