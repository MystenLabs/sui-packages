module 0x38d08d49373ab72e70dd87ddd3a203e3eca5f640d97d0a86901a9374a3cff799::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05574154455205574154455262537461792048796472617465642e0a546865206d6f7374206c6971756964206173736574206f6e205375692e0a2457415445527c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f2b4b78484734526b47686f51345a545139227d6e68747470733a2f2f706c756d2d6c6567616c2d686164646f636b2d3939332e6d7970696e6174612e636c6f75642f697066732f6261667962656962766c756d753465696a6b766c727771716d6577696e746e377074657865616c6a76776a6e36336a6175376f3461616c74343334");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

