module 0x4c5565f4f57d5bfcf79f4822268d6ad9e84256b1c39b343b36e5ee38d939435c::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TESTCOIN>>(0x2::coin::mint<TESTCOIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 9, b"TESTCOIN", b"TEST", b"Test Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

