module 0xcfdf422e99550a786bbca6a478a4d319c348ea172dd64b62d93b96c91ebf4731::constants {
    public fun blue_reward_type() : 0x1::string::String {
        0x1::string::utf8(b"dd5c4badc89f08fb2ff3c1827411c9bafbed54c64c17d8ab969f637364ca8b4f::blue::BLUE")
    }

    public fun fee_rate_denominator() : u64 {
        1000000
    }

    public fun manager() : 0x1::string::String {
        0x1::string::utf8(b"manager")
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
        1152921504606846975
    }

    public fun max_u8() : u8 {
        255
    }

    public fun protocol_fee_share() : u64 {
        250000
    }

    public fun q64() : u128 {
        18446744073709551616
    }

    // decompiled from Move bytecode v6
}

