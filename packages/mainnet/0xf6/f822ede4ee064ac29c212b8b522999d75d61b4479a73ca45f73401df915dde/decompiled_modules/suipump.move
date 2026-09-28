module 0xf6f822ede4ee064ac29c212b8b522999d75d61b4479a73ca45f73401df915dde::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"084e4541524c494f53084e6561726c696f739601f09f8c8c204e4541524c494f53207c204275696c74206f6e2053756920e29aa10af09fa68120436f6d6d756e6974792d64726976656e2e204a7573742067657474696e6720737461727465642e7c7c7b2274656c656772616d223a2268747470733a2f2f746d2e6e6561726c696f736530222c2274776974746572223a2268747470733a2f2f782e636f6d2f4e6561726c696f73227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f34313630303536383865343432366439663835303362316138386139333635312e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

