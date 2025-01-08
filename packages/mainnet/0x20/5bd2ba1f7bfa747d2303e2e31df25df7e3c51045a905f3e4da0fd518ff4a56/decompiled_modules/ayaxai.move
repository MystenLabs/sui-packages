module 0x205bd2ba1f7bfa747d2303e2e31df25df7e3c51045a905f3e4da0fd518ff4a56::ayaxai {
    struct AYAXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYAXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AYAXAI>(arg0, 6, b"AYAXAI", b"Ayex Ai  by SuiAI", b"Welcome to Ayex Your AI Powered Crypto Market Analysis Hub", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1888_98405242f2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AYAXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYAXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

