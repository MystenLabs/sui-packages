module 0xece15a01f0507d7be78517131aae4501b6e7323d552160b2410ea24f25c9be54::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0753554952544c450753756972746c659b01412072617265205375692d6e617469766520506570c3a96d6f6e20686173206170706561726564e280a67c7c7b2274656c656772616d223a2268747470733a2f2f782e636f6d2f53756972746c65654f6e537569222c2274776974746572223a2268747470733a2f2f782e636f6d2f53756972746c65654f6e537569222c2277656273697465223a22742e6d652f53756972746c654d656d65227d2068747470733a2f2f692e696d6775722e636f6d2f51335345794c4d2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

