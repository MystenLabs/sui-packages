module 0xba7d104bf2e206df002ae87bd4bd402b6f4d41562824584618a9668d00e2c4fe::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044e414e47044e616e676c7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6e616e6773756965222c2274776974746572223a2268747470733a2f2f782e636f6d2f6e616e675f222c2277656273697465223a2268747470733a2f2f742e6d652f6e616e67737569652e636f6d227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f62646265313263626433366633393663633333316365383164323331393262302e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

