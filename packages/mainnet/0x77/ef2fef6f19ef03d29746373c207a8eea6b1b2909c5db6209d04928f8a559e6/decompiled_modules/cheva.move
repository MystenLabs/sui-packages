module 0x77ef2fef6f19ef03d29746373c207a8eea6b1b2909c5db6209d04928f8a559e6::cheva {
    struct CHEVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHEVA>(arg0, 6, b"CHEVA", b"Chevalanier Sui by SuiAI", b"Chavelainer: The AI of Elegance and Innovation.Chavelainer is not just an AI agent; it's a symbol of refinement and cutting-edge intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cheva_06c66fc742.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHEVA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEVA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

