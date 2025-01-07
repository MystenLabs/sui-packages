module 0x2c0b5cdc1d92570d454f2ef5d420df1e686c466d96371e1984cbc14def9d1fc6::suimpson {
    struct SUIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPSON>(arg0, 6, b"SUIMPSON", b"BART SUIMPSON", b"\"Suimpson\" is a vibrant and playful meme coin inspired by The Simpsons and the Sui blockchain, featuring a cast of characters with distinct personalities. Each character, like Suimpson himself, sports a blue skin tone in homage to the Sui brand, blending iconic cartoon aesthetics with the futuristic world of cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimpson_2f79fa368c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

