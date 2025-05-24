module 0x25d5a5401f2a1d9e9bc8cac4dbeef8a326774fa81dd6f78e5cf93f0e9c862868::mistresscoin {
    struct MISTRESSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTRESSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MISTRESSCOIN>(arg0, 6, b"MISTRESSCOIN", b"MistressCoin", b"A mature older woman named Mistress. Dark and mysterious. [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/w3dB14.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MISTRESSCOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTRESSCOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

