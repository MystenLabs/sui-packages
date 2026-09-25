module 0xc90107cf27725cda5392104be2044b9d9f490def88ac3fd57e7d1fb265871d8d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"054d4f4e4e49054d6f6e6e69b201546865206f6666696369616c206d6173636f74206f6620244d4f4e4e49206f6e2053756920f09f8c8a0a4368696c6c696e67206f6e2074686520626c6f636b636861696e202e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6d6f6e6e695f737569222c2274776974746572223a2268747470733a2f2f782e636f6d2f6d6f6e6e69646f7466756e222c2277656273697465223a2268747470733a2f2f6d6f6e6e692e66756e2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f32356131623461333466373532616434313533313531663431653832616561642e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

