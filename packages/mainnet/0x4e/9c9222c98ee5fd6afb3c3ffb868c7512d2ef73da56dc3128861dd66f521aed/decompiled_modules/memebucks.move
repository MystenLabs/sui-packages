module 0x4e9c9222c98ee5fd6afb3c3ffb868c7512d2ef73da56dc3128861dd66f521aed::memebucks {
    struct MEMEBUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEBUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEBUCKS>(arg0, 9, b"MEMEBUCKS", b"XMemebucks", b"Introducing Memebucks, the most entertaining meme coin in the crypto world! Created to spread laughter and joy, Memebucks presents a unique design with cute characters ready to entertain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f82004c0-8c8a-4d65-8e56-7c9657499998.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEBUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEBUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

