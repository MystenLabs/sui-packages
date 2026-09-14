module 0xd58df183de663787bbdee9a11e77f5351ba7bfa6cac30eb49cbb72ebcf24c0c9::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05424c4f524205424c4f52425f426c6f726420746f6b656e204d6f6f6e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f626c6f72626d656d65686f6f64222c2274776974746572223a2268747470733a2f2f782e636f6d2f626c6f72626d656d65227d5268747470733a2f2f6173736574732e636f696e6765636b6f2e636f6d2f636f696e732f696d616765732f3130323137383238372f7374616e646172642f6d6173636f742e706e673f31373839323334343832");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

