module 0x5940adef89d756a12b8a7cf9ee97ea538120931cf38896fcf39a02c840c370bf::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 6, b"Testcoin", b"Test", b"Don't buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiff3r2ietxf54zuhj6ghnamhaz3fddm3ikiznqtfc2zkcszslwf3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

