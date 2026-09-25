module 0x4d3fd3cad3adbaef32273b3712dd318243de6172c9ad0fed8a32413c0a8ba58e::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"08454d414e4142494f0b4164656e6979692e7375696d436f2d666f756e64657220262043504f20617420404d797374656e5f4c616273204275696c64696e6720405375694e6574776f726b2026204057616c72757350726f746f636f6c7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f456d616e4162696f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f66643064633766393663633333636438313764653662383233373939306333612e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

