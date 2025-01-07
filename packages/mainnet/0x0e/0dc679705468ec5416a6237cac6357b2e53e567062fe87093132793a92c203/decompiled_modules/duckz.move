module 0xe0dc679705468ec5416a6237cac6357b2e53e567062fe87093132793a92c203::duckz {
    struct DUCKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKZ>(arg0, 6, b"DUCKZ", b"SuiDuckz", b"suiduckz.com . It's about quackin time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I_Fen_K9l_400x400_9c00b8b31a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

