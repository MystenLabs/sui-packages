module 0x70f556cc38edff9d3eed7f2a8a6edfbe152131425f2dd1091e55315abd710612::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"LUNAR by SuiAI", b"Be the first to chat with the real caracters from the upcoming game , trailer for the big game will be releasing next week ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/gta6_0f98a21169.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

