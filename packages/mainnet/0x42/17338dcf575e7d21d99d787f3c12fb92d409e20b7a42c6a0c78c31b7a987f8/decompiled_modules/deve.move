module 0x4217338dcf575e7d21d99d787f3c12fb92d409e20b7a42c6a0c78c31b7a987f8::deve {
    struct DEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVE>(arg0, 9, b"DEVE", b"Devils Eye", b"Devil Eye is a meme token demonstrates how the level of evil today. This meme is the only meme that will never request for gas fee, this meme can only be use on sports like wwe, kick boxing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2b4c1d50-3ff7-49cf-8022-29de5eaa2687.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

