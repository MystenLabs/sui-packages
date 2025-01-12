module 0x62d1d17ea42c3279988b19eae27b585e3bd020e745b9e59b5f5fd26a259e9267::tino {
    struct TINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TINO>(arg0, 6, b"TINO", x"54494e4fe3808ae3808b4169206279205375694149", b"Tino is a futuristic agent with holographic elements and softly glowing eyes, symbolizing insight and intelligence. He combines human warmth with technological perfection, inspiring trust and reliability..Agent Tino is here to make life easier, more productive, and more exciting. Always ready to be your trusted partner!..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000022648_c2a4ef9c1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TINO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

