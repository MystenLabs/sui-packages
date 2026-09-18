module 0xa172cad8c4e4a36091d44d6bb08f8e615050e003f5b9f514df0fb70762e777f8::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044c414255094c617a657242756c6c4e7c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f4c61737365725f42756c6c222c2274776974746572223a2268747470733a2f2f782e636f6d2f6c617365725f62756c6c227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f39626661343062363161303237333631396165333231663837656465373139352e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

