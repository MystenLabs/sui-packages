module 0xff9dc67b08915aa08ba68512894ac0d66c7aba2951bace322197303291619e4d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"085a454e4f4a535549055a656e6f6ac101e29aa1205a454e4f4a205355490a4275696c74206f6e205375692e20506f77657265642062792074686520636f6d6d756e6974792e20f09f928e0a4a7573742067657474696e6720737461727465642e20f09f9a807c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f7a656e6f6a73756965222c2274776974746572223a2268747470733a2f2f782e636f6d2f30785a656e6f73222c2277656273697465223a2268747470733a2f2f742e6d652f7a656e6f6a73756965227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f33323738396639323432643763643234353437393032626134663033626333352e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

