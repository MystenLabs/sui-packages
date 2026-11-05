module 0xe57100e7851132a107d2071a57bb2a46c2bd7b09a83fceec28a0cfc3af5321cc::suipump_duel {
    struct SUIPUMP_DUEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP_DUEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044455454c0f6475656c6f6e636861696e2e78797a2b7c7c7b2277656273697465223a2268747470733a2f2f7375692e6475656c6f6e636861696e2e78797a227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f36323065366461383738353664396439303964316334333534663538643166652e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP_DUEL>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP_DUEL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP_DUEL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

