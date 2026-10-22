module 0x386f3204a8163b7b06c2ec11a180e0f242d37743d74633bbcac0d96110191b8b::xaut {
    struct XAUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAUT>(arg0, 9, b"XAUT", x"e9bb84e98791e78eb0e8b4a7", b"Template Coin Description", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XAUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

