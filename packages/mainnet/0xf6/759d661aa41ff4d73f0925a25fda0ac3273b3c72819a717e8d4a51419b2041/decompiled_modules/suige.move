module 0xf6759d661aa41ff4d73f0925a25fda0ac3273b3c72819a717e8d4a51419b2041::suige {
    struct SUIGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGE>(arg0, 6, b"SUIGE", b"DOGE BUT SUI", b"Suige is a meme coin that features a blue dog in a suit, combining a playful and professional aesthetic. Positioned to grow through community engagement, Suige taps into the fun and lighthearted nature of the crypto space while embracing the power of collective support.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suige_7717a1fe07.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

