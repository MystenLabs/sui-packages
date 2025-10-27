module 0xc5855da52c6ded4e9e7d31f4d80452b3a9746133969f837ca9c483311b7f7adf::runes {
    struct RUNES has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNES>(arg0, 6, b"RUNES", b"RUNESTONE", b"Legendary warrior god fighter, red, in the complete jungle \"legendary fighter\", warrior confrontation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1761597566981.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUNES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

