module 0xfcf06325f17d9c223582344451a336c475edff4cbc8bc1d84543d9ed8e7aa9c9::suimp {
    struct SUIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMP>(arg0, 6, b"SUIMP", b"Bart Suimpson", b"\"Suimpson\" is a vibrant and playful meme coin inspired by The Simpsons and the Sui blockchain, featuring a cast of characters with distinct personalities. Each character, like Suimpson himself, sports a blue skin tone in homage to the Sui brand, blending iconic cartoon aesthetics with the futuristic world of cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimpson_16f8d2b66f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

