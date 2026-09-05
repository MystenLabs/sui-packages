module 0xeb195778afba241590237cd6ca17c479b4fb09047c2a2ef2ee6a9346698d6827::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"064c4f4649484f084c6f6669486f6f6474537465616c2066726f6d20526f62696e686f6f642e2050757420697420696e746f205375692e20f09f92a77c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6c6f6669686f6f64222c2274776974746572223a2268747470733a2f2f782e636f6d2f6c6f6669686f6f64227d2068747470733a2f2f692e696d6775722e636f6d2f46434a463364632e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

