module 0x272a9906112b4188eb37361d988c239ce2cf38f5e77a45a349987fe02d705760::cappy {
    struct CAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPY>(arg0, 6, b"CAPPY", b"cappybobo", x"5472696564206120646966666572656e742077617920746f2075736520446546692e0a0a4e6f20636f6d706c6963617465642073657475702c206e6f2067657474696e67206c6f737420696e206e6574776f726b732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1774025082774.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

