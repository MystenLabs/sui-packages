module 0xe2eef739541d8112f5357f978d33b825a8ebe9e9f655c4f4180a2d595b2a3f22::flix {
    struct FLIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIX>(arg0, 6, b"FLIX", b"NetSui", b"The most exciting agent on sui! The agent will respond with an iconic phrase from a Netflix series!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737065483282.05")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

