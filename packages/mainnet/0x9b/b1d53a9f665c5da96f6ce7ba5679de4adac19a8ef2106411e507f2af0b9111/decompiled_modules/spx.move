module 0x9bb1d53a9f665c5da96f6ce7ba5679de4adac19a8ef2106411e507f2af0b9111::spx {
    struct SPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX>(arg0, 6, b"SPX", b"SPX6900 SUI", b"Welcome to the S&P6900, an advanced blockchain cryptography token with limitless possibilities and scientific utilization. Imagine the power of the whole entire stock market put inside little tiny crypto coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suix6900_png_02f95ab6df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

