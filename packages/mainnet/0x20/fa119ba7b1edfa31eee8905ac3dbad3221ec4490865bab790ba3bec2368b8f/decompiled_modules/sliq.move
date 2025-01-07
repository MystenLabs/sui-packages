module 0x20fa119ba7b1edfa31eee8905ac3dbad3221ec4490865bab790ba3bec2368b8f::sliq {
    struct SLIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIQ>(arg0, 6, b"SLIQ", b"LIGUOR", b"Free booze for every sui holder. Reward token for sui ecosystem. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730460224264.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLIQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

