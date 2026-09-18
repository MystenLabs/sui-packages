module 0x1b260693ce5d79f06531830ae7e8e0590b66c9722e22b802b2a258b9c91c669::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"034c53430c4c65742073756920636f6f6b457c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f4d724272656164536d6974682f7374617475732f32313030393437383531393530313239313939227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f66656436303836613466353762326339323932353630646137393466626263362e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

