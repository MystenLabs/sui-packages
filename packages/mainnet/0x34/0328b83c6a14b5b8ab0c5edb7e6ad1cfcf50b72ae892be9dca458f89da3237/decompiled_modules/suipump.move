module 0x340328b83c6a14b5b8ab0c5edb7e6ad1cfcf50b72ae892be9dca458f89da3237::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05424f524f5309424f524f53204341548a0143616c6c65642062792068747470733a2f2f782e636f6d2f537569576f726c64426c6f782076696120404f7572626c617374626f742022404f7572626c617374626f74206465706c6f79206120746f6b656e204e616d653a20424f524f5320434154205469636b65723a2024424f524f532068747470733a2f2f742e636f2f703561613148316d6964222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f485373364373756149414148562d742e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

