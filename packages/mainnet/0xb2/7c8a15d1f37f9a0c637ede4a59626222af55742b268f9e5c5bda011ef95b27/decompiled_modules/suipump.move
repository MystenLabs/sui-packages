module 0xb27c8a15d1f37f9a0c637ede4a59626222af55742b268f9e5c5bda011ef95b27::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0943524142444f5453550a43726162446f74537569b501e2808bf09f8c8a204465657020646976696e6720696e746f20245355492e2050696e6368696e67206761696e732c206578706c6f72696e6720446546692c20616e642067726f77696e6720776974682074686520636f6d6d756e6974792e20f09fa680e29ca87c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f43726162446f745375693037222c2274776974746572223a2268747470733a2f2f782e636f6d2f43726162446f74537569227d2068747470733a2f2f692e696d6775722e636f6d2f415041626c324b2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

