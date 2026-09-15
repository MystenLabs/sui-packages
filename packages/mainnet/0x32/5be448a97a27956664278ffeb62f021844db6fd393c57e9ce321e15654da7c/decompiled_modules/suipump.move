module 0x325be448a97a27956664278ffeb62f021844db6fd393c57e9ce321e15654da7c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044252554804427275683d4272756820427275682042727568204d6f6f6e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f74756d6e75747461776f6f74227dfd0168747470733a2f2f696d616765732e70756d702e66756e2f636f696e2d696d6167652f3674526f744779704135514a4b776d66674746653479703336654e5134567a376d384d4e4e70426e70596d713f76617269616e743d383078383026697066733d6261666b72656961636b65786f35676134366232776b7568786b636877746d776437347a78626e37696d6d7476746e636d62766370696f746f3671267372633d6874747073253341253246253246697066732e696f253246697066732532466261666b72656961636b65786f35676134366232776b7568786b636877746d776437347a78626e37696d6d7476746e636d62766370696f746f3671");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

