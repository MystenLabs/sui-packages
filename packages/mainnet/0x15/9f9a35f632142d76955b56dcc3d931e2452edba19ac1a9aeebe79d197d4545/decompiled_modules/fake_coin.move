module 0x159f9a35f632142d76955b56dcc3d931e2452edba19ac1a9aeebe79d197d4545::fake_coin {
    struct FAKE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE_COIN>(arg0, 9, b"FAKE", b"FAKE", b"FAKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAKE_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

