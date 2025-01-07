module 0xb153df7c6a00111ebf2115f9fdcde5023af5c8d26eebf5bb652641cb7dbac90::gachi {
    struct GACHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GACHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GACHI>(arg0, 9, b"GACHI", b"Gachi", b"The Japanese word hatimuti means \"pumped up big man\"; hachimuchi is an Internet subculture based on the plot of gay films of the 1990s.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a161e0e-5cab-4305-ada7-8b8f6abd58db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GACHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GACHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

