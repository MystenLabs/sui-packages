module 0x62b4e22f5c74ff65605296fd6641e73c701682dfa18490da6043f593dea79447::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"MEMELAND", b"Meme island", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ef83021-3caf-4c9b-b4a5-ee7a6d0f3dcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

