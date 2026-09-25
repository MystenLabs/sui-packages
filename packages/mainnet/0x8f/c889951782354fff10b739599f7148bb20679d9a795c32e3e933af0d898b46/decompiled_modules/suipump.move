module 0x8fc889951782354fff10b739599f7148bb20679d9a795c32e3e933af0d898b46::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"05524f4e44410c526f6e6461206f6e2073756999015468652046617374207265616c20646f6720696e2073756920f09f90957c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f726f6e64616f6e737569706f7274616c222c2274776974746572223a2268747470733a2f2f782e636f6d2f726f6e64616f6e7375693f733d3131222c2277656273697465223a2268747470733a2f2f726f6e64616f6e7375692e78797a2f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f62616436653733616634383738636534656336396139393132376530656133392e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

