module 0x739017c25273532f7a70a1c327124337ddfdda60ab98e2de9ff4e831bcbe53ae::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"054641495448054641495448a701464149544820e2809420412047616d65206f662042656c6965662c204368616e63652c20616e6420446976696e6520526577617264206f6e205375697c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6661697468646f746767222c2274776974746572223a2268747470733a2f2f782e636f6d2f6661697468646f746767222c2277656273697465223a2268747470733a2f2f66616974682e67672f227d2068747470733a2f2f692e696d6775722e636f6d2f324964674167382e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

