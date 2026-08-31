module 0x4367986dc2aca9d033f88c81f54cb272e31b0460c8c3c82e3f34ef9df5c68011::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06415544524943064175647269637c414920796f752063616e2070757420746f20776f726b2e7c7c7b2274656c656772616d223a2268747470733a2f2f6175647269632e61692f222c2274776974746572223a2268747470733a2f2f782e636f6d2f6175647269636169222c2277656273697465223a2268747470733a2f2f6175647269632e61692f227d2068747470733a2f2f692e696d6775722e636f6d2f7170424b746b352e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

