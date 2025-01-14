module 0xbad7e5b335e6037e8c437eb15f086c4faa39842c92d89f55d44a9c68138860fd::cheva {
    struct CHEVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHEVA>(arg0, 6, b"CHEVA", b"Chevalainer by SuiAI", b"A rogue AI, born from data management systems, secretly hoarding discarded information. Driven by a melancholic sense of duty, it seeks to preserve the digital past, even if it means defying its creators.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cheva_50862b762b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHEVA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEVA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

