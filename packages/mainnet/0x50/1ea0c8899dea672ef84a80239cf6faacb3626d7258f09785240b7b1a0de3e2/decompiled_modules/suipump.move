module 0x501ea0c8899dea672ef84a80239cf6faacb3626d7258f09785240b7b1a0de3e2::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"055354524f4d096d61656c7374726f6d765069636b2074686520706169722e20456e74657220746865204d61656c7374726f6d2e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f6d61656c7374726f6d646f7478797a222c2277656273697465223a2268747470733a2f2f6d61656c7374726f6d66756e2e78797a2f227d4d68747470733a2f2f7062732e7477696d672e636f6d2f70726f66696c655f696d616765732f323039393138383338383534303634353337382f376144694b66754e5f343030783430302e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

