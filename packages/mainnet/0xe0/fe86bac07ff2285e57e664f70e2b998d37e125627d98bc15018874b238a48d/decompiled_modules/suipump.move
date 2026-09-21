module 0xe0fe86bac07ff2285e57e664f70e2b998d37e125627d98bc15018874b238a48d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0955544f5049415355490655544f504941d501f09f8c8c2055746f706961537569207c202455544f5049410a41206e657720766973696f6e206f6e2053756920f09f928e0a436f6d6d756e69747920e280a220566962657320e280a22046757475726520f09f9a807c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f426c6173746e6f7466756e5f43544f222c2274776974746572223a2268747470733a2f2f782e636f6d2f42656c61796e65736873656e626574222c2277656273697465223a2268747470733a2f2f742e6d652f426c6173746e6f7466756e5f43544f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f35323866363361353962346634663835656364396535306130316236623532352e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

