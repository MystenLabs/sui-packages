module 0xcd5c24d863e45aed82a4e215ed7e63209b11b8262a06301469e6a6c47f96a59f::testfeeboos {
    struct TESTFEEBOOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTFEEBOOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTFEEBOOS>(arg0, 6, b"testfeeboos", b"testfeeboost", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTFEEBOOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTFEEBOOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

