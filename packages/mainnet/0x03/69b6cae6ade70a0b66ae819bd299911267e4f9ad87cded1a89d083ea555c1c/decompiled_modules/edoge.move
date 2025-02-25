module 0x369b6cae6ade70a0b66ae819bd299911267e4f9ad87cded1a89d083ea555c1c::edoge {
    struct EDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOGE>(arg0, 6, b"EDOGE", b"Elon Doge", b"A meme coin inspired by Elon Musk, the man who can shake the entire crypto market with just one tweet. Elon Doge (EDOGE) is not only a meme coin, but also a symbol of creativity, technology and the future of Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/a8dd5372-ac54-4b39-a3ae-635a39d6fc32.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

