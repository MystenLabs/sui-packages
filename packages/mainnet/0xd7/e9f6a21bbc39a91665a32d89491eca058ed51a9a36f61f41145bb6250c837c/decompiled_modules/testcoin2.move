module 0xd7e9f6a21bbc39a91665a32d89491eca058ed51a9a36f61f41145bb6250c837c::testcoin2 {
    struct TESTCOIN2 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN2>>(0x2::coin::mint<TESTCOIN2>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: TESTCOIN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN2>(arg0, decimals(), b"TEST_COIN_2", b"TEST_COIN_2", b"Native TEST_COIN_2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

