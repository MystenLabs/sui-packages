module 0x43571977ed5940495d918ba947080970e5cab02454e3e51f4fa8158405c67423::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0744415645535549046461766593014461766520686f6c64657220436f6d696e677c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f7072696e74737569776461766563686174222c2274776974746572223a2268747470733a2f2f782e636f6d2f646176656f6e746865776179222c2277656273697465223a2268747470733a2f2f742e6d652f7072696e74737569776461766563686174227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f66343664343463363161376131626335363538383661623634623231656330382e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

