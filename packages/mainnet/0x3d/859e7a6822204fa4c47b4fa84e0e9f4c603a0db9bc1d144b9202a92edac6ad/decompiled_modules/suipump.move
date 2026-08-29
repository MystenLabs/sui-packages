module 0x3d859e7a6822204fa4c47b4fa84e0e9f4c603a0db9bc1d144b9202a92edac6ad::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04534855490ce4b88ae59684e88ba5e6b0b462e4b88ae59684e88ba5e6b0b4efbc8ce6b0b4e59684e588a9e4b887e789a9e8808ce4b88de4ba897c7c7b2277656273697465223a2268747470733a2f2f7777772e796f75747562652e636f6d2f77617463683f763d79556a5046436f736d4e41227d1f68747470733a2f2f692e696d6775722e636f6d2f7843674a3979652e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

