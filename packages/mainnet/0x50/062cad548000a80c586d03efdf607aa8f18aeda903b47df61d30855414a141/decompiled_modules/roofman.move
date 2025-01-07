module 0x50062cad548000a80c586d03efdf607aa8f18aeda903b47df61d30855414a141::roofman {
    struct ROOFMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOFMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOFMAN>(arg0, 6, b"Roofman", b"ManOnRoof", b"Random man on roof. No strings. Risky. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732207418092.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROOFMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOFMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

