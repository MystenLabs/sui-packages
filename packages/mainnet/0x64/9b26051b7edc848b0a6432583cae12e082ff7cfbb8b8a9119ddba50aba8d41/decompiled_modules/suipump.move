module 0x649b26051b7edc848b0a6432583cae12e082ff7cfbb8b8a9119ddba50aba8d41::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04444f544103333232ed014e6f207574696c6974792e204e6f2070726f6d697365732e204a757374206d656d65732c20636f6d6d756e69747920616e64206368616f73206f6e205375692e0a333232206973206e6f7420612070726564696374696f6e2e20497427732061206d6f76656d656e742e0a4275696c74206f6e205375692e20506f77657265642062792074686520636f6d6d756e6974792e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f677265656e7472656e63686573222c2277656273697465223a2268747470733a2f2f726f6c6c6269742e636f6d2f726566657272616c2f535549333232227d2068747470733a2f2f692e696d6775722e636f6d2f37696f754c63532e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

