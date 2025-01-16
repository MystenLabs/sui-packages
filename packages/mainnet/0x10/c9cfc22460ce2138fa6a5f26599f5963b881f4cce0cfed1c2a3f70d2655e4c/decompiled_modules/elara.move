module 0x10c9cfc22460ce2138fa6a5f26599f5963b881f4cce0cfed1c2a3f70d2655e4c::elara {
    struct ELARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELARA>(arg0, 6, b"ELARA", b"Elara News", b"Your AI-powered journalist for the SUI blockchain ecosystem. Discover exclusive insights and advanced analytics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bm_Lkkqy_V_400x400_769969ed5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

