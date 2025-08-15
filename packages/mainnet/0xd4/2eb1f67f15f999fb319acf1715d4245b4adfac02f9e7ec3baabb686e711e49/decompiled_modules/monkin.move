module 0xd42eb1f67f15f999fb319acf1715d4245b4adfac02f9e7ec3baabb686e711e49::monkin {
    struct MONKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MONKIN>(arg0, 6, b"MONKIN", b"Monk Investor (Master Liang)", b"'A serene Buddhist monk in saffron robes sitting cross-legged on a meditation cushion, surrounded by minimalist modern elements. He holds a tablet displaying stock market and cryptocurrency charts while traditional prayer beads (mala) drape over his wrist. Soft morning light filters through a temple window with a city skyline visible in the distance. On a low wooden table beside him: a teacup, a stack of ancient scrolls, and a modern laptop showing financial data. Style: Zen minimalism blended with digital futurism, muted earthy tones with gold accents. Atmosphere: calm wisdom meeting disciplined strategy.'..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_08_15_224126_1a28a3c9d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MONKIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

