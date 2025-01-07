module 0x3471c19f73a928e53108af0495babe16bb5b8f2c40bac9c3ffb9dba5033f5178::meki {
    struct MEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKI>(arg0, 9, b"MEKI", b"Maneki", b"Maneki-Coin (MEKI) is a unique digital collectible token inspired by the Japanese Maneki-Neko (Lucky Cat) legend. MEKI embodies the symbolism of good fortune, prosperity, and success in the cryptocurrency market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0e4f036-212f-4b43-9f1e-9556adfa198d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

