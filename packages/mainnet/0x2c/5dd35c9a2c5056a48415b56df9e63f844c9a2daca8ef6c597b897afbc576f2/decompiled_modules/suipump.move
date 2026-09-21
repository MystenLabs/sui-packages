module 0x2c5dd35c9a2c5056a48415b56df9e63f844c9a2daca8ef6c597b897afbc576f2::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"074a45455445525312415645524147452053554920545241444552b00143616c6c65642062792068747470733a2f2f782e636f6d2f656c6c656c656f6f2076696120404f7572626c617374626f742022404d6a626472616e20404f7572626c617374626f7420404f7572626c617374626f74206465706c6f79206120746f6b656e204e616d65203a20415645524147452053554920545241444552205469636b6572203a204a45455445525320496d616765203a2068747470733a2f2f742e636f2f437a336131315565535a222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f4853746d69675361734141736f4e392e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

