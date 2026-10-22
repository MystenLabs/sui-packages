module 0x41c32280bb6b8514366cf859d35850368873e28e8bbaaac842c98eb3c0e10aeb::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"045a415053045a415053654d696e65205a415073207468726f7567682074686520434f4e534f204d696e6572204170707c7c7b2274776974746572223a22636f6e736f5f78797a222c2277656273697465223a2268747470733a2f2f7777772e636f6e736f2e78797a2f626f7473227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f64636132633564336464646431393266643264646463343461656366366465632e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

