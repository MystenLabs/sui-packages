module 0x80ec8d5ffe73e02221f6f78f4d6583c6e65811edba0f3c74a00b880345b31fff::constants {
    public fun blue_reward_type() : 0x1::string::String {
        0x1::string::utf8(b"9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint::BPOINT")
    }

    public fun manager() : 0x1::string::String {
        0x1::string::utf8(b"manager")
    }

    public fun max_allowed_fee_rate() : u64 {
        20000
    }

    public fun max_allowed_tick_spacing() : u32 {
        400
    }

    public fun max_observation_cardinality() : u64 {
        1000
    }

    public fun max_protocol_fee_share() : u64 {
        500000
    }

    public fun max_u128() : u128 {
        340282366920938463463374607431768211455
    }

    public fun max_u16() : u16 {
        65535
    }

    public fun max_u256() : u256 {
        115792089237316195423570985008687907853269984665640564039457584007913129639935
    }

    public fun max_u32() : u32 {
        4294967295
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun max_u8() : u8 {
        255
    }

    public fun pool_creation_fee_dynamic_key() : 0x1::string::String {
        0x1::string::utf8(b"pool_creation_fee")
    }

    public fun protocol_fee_share() : u64 {
        200000
    }

    public fun q64() : u128 {
        18446744073709551616
    }

    // decompiled from Move bytecode v6
}

