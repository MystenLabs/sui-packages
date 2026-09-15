module 0xf5bee2a72a4911c8c25b9b45595f4a206f6d12cb1dd5749f48ab674136262dba::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"035a434c085a636c61737369634f7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f7a636c61737369636365222c2274776974746572223a2268747470733a2f2f782e636f6d2f7a636c6173736963636f696e227d4e68747470733a2f2f6173736574732e636f696e6765636b6f2e636f6d2f636f696e732f696d616765732f3534302f7374616e646172642f7a636c61737369632e706e673f31363936353031373539");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

