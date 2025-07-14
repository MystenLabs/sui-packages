module 0x363ed0c88d73d839c01ab2a9cb81718854457ca714b1be33bceea0d6784bf96e::bullish {
    struct BULLISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLISH>(arg0, 6, b"Bullish", b"Good token", b"Ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia3xqeazm4lrhu2ner6va4zbrujw5cja7cbj3u45c7jzb5wunx7nm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLISH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

