module 0x61b581ec61dcef944bf2c646f1a1d719c683777d881507abe29ad886c09e923c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"055355494341105375696361205468652052616262697480014a7245617374206d6173636f74206c6976696e67206f6e207375692c206a6f696e2074686520747261696e217c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f5375696361546865526162626974222c2277656273697465223a2268747470733a2f2f73756963617468657261626269742e78797a2f227d1f68747470733a2f2f692e696d6775722e636f6d2f734235495a39652e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

