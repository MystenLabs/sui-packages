module 0x6bce13f1479282b9b24c3cd87ef1035990a35d7df9d5c8ea9fbc58943a5931ae::xaut {
    struct XAUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAUT>(arg0, 9, b"XAUT", x"e9bb84e98791e7a8b3e5ae9ae5b881", b"Template Coin Description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XAUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

