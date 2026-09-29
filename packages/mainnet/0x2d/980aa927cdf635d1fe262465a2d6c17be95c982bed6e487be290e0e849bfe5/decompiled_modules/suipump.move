module 0x2d980aa927cdf635d1fe262465a2d6c17be95c982bed6e487be290e0e849bfe5::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05534f4645450c53656564206f7220666565648e01534f464545206973206120746f6b656e20666f72206661726d6572732074686174206e656564207365656420666f7220666565647c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f6b6c696b5f65766d2f7374617475732f32313034353533383832303830363439353832222c2277656273697465223a226b6c696b2e66696e616e6365227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f63336239646533393465366164353462643535353165303665653033396561612e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

