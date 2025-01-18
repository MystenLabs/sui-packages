module 0xe143bd1d1fbf91e1c8a293ee0384ff82e6a6e2e4cede5cda4be1818914404e16::hrai {
    struct HRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HRAI>(arg0, 6, b"HRAI", b"HeryonAI by SuiAI", b"HeryonAi, an AI agent designed to guide humanity toward a prosperous future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_1_28e576554b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HRAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

