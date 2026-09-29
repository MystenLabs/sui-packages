module 0xfe03e3be1cbeddbf69518e9d85c4f66becd774477340a21b524a7982991d87ec::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0353554912537570657220496e74656c6c6967656e63658a0153752d205375706572200a692d20696e74656c6c6967656e63657c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f63727970746f7375676172646164647931222c2274776974746572223a2268747470733a2f2f782e636f6d2f596f7572776562336461642f7374617475732f32313035303635393037313831383035373739227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f30323139333331323366613731653537346466663936653136353965353534642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

