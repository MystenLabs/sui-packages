module 0x7dc6a6c6c0894d5841c44bff17bf5a80011545c529be2d9ec368be0339c51dcc::kensteph75 {
    struct KENSTEPH75 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENSTEPH75, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENSTEPH75>(arg0, 9, b"KENSTEPH75", b"dafgosteph", b"Even number generator MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43aa6e41-5d15-4cec-ad01-8d9f33bc3aed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENSTEPH75>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENSTEPH75>>(v1);
    }

    // decompiled from Move bytecode v6
}

