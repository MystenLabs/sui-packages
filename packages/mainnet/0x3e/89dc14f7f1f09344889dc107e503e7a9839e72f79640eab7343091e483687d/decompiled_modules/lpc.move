module 0x3e89dc14f7f1f09344889dc107e503e7a9839e72f79640eab7343091e483687d::lpc {
    struct LPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPC>(arg0, 9, b"LPC", b"Lollypop", b"lollypop Is Community Base Memecoin Project which Is Designed for the Active Community Members,who Strongly Hold The Coin For Long Term To Support The Project Growing & Attracting New Investors and Other Projects Partnerships, ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b683a53-19eb-4052-9921-5ad870ba09a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

