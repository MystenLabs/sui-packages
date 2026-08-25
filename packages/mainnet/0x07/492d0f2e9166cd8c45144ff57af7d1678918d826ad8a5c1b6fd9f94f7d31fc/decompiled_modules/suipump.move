module 0x7492d0f2e9166cd8c45144ff57af7d1678918d826ad8a5c1b6fd9f94f7d31fc::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"054e45575043094d79206e65772050439501576527726520616c6c206865726520666f72206f6e6520676f616c3a20627579696e672074686174206162736f6c757465206265617374206f6620612050432e20244e455750432069732074686520636f6d6d756e69747920746f6b656e2064726976696e6720796f7572206a6f75726e65792066726f6d20706f7461746f20504320746f20756c74696d6174652073657475702e2068747470733a2f2f692e696d6775722e636f6d2f6b5066325137312e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

