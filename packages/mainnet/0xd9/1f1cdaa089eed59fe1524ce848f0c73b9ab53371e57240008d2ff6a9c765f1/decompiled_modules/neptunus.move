module 0xd91f1cdaa089eed59fe1524ce848f0c73b9ab53371e57240008d2ff6a9c765f1::neptunus {
    struct NEPTUNUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUNUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUNUS>(arg0, 6, b"NEPTUNUS", b"Neptunus", b"Neptunus Bot is an advanced, AI-powered trading assistant designed to optimize your crypto trading experience on the Solana, Ethereum, Binance, & SUI blockchain. Using cutting-edge machine learning algorithms and real-time market analysis, Neptunus Bot helps traders identify lucrative opportunities while minimizing risks in volatile markets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_17_18_32_14_482fb54d26.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUNUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPTUNUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

