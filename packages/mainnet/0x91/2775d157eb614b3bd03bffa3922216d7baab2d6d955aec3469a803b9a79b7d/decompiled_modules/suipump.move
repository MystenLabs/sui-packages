module 0x912775d157eb614b3bd03bffa3922216d7baab2d6d955aec3469a803b9a79b7d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0753554942554c4c0c546865205375692042756c6c7254686520426c75652042756c6c7c7c7b2274656c656772616d223a22742e6d652f53756942756c6c43686174222c2274776974746572223a2268747470733a2f2f782e636f6d2f53756942756c6c4d656d65222c2277656273697465223a226c696e6b74722e65652f73756962756c6c227d2068747470733a2f2f692e696d6775722e636f6d2f7852635643506c2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

