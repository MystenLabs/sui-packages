module 0xea9f0454fde9eb8ed99beda1fc6b5655fa903ec793b2a62a02ed13026c85a523::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"074348455353494f074368657373696fc501e29994204368657373696f2028244348455353494f290a537569206d61696e6e6574200a54686520726f79616c20636f7572742e204368617274732c2062616e7465722c20616e64207468652063726f776e2e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6368657373696f5f67726f7570222c2274776974746572223a2268747470733a2f2f782e636f6d2f4368657373696f5f78797a222c2277656273697465223a2268747470733a2f2f6368657373696f2e78797a2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f33343263373935363233393537303234613464383066303730363630306632662e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

