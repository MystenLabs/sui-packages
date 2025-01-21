module 0x7287067ad85c9ef822437f153fc534180758ab55cf4e3dc0e2417c37d04d4291::amer {
    struct AMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AMER>(arg0, 6, b"AMER", b"AmericaGO by SuiAI", b"One speed GO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/one_speed_go1_582a69b1db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AMER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

