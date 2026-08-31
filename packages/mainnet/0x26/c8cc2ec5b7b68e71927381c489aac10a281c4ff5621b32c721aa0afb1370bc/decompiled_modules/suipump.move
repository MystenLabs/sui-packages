module 0x26c8cc2ec5b7b68e71927381c489aac10a281c4ff5621b32c721aa0afb1370bc::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034855480748494820434154890148756820487568204875682048756820487568204875687c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6875686361746e6164222c2274776974746572223a2268747470733a2f2f782e636f6d2f4875686361744e6164222c2277656273697465223a2268747470733a2f2f7777772e6875686361746e61642e78797a2f227d2068747470733a2f2f692e696d6775722e636f6d2f6f723077714b4d2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

