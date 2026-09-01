module 0x616f25832b062989038a77c15694eba9a94a1a16d767c8a7a0cfd4c05853b7fc::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0342554204425542417e546865204368616f74696320476f6f642057697a617264206f66207468652053554920426c6f636b636861696e2e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f627562616f6e737569222c2274776974746572223a2268747470733a2f2f782e636f6d2f627562616f6e7375693f733d3131227d2068747470733a2f2f692e696d6775722e636f6d2f6972693059317a2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

