module 0x34678403fc6679fa68fc04098e7bc2524c14ea1798aba859fc42c05fb3baa9e9::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN>>(0x2::coin::mint<TESTCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 9, b"TESTCOIN", b"TEST", b"Test Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

