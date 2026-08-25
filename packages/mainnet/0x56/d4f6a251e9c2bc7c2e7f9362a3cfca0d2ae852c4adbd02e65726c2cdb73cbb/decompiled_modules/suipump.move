module 0x56d4f6a251e9c2bc7c2e7f9362a3cfca0d2ae852c4adbd02e65726c2cdb73cbb::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034f4e450a4a7573744f6e655375697b4a7573744f6e655375697c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6a7573746f6e6573756969222c2274776974746572223a2268747470733a2f2f782e636f6d2f6a7573746f6e65737569222c2277656273697465223a22687474703a2f2f6a7573746f6e657375692e66756e2f227d2068747470733a2f2f692e696d6775722e636f6d2f4b69464b4a30612e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

