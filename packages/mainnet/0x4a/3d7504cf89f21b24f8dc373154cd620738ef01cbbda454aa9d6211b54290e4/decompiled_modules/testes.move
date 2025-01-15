module 0x4a3d7504cf89f21b24f8dc373154cd620738ef01cbbda454aa9d6211b54290e4::testes {
    struct TESTES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTES>(arg0, 6, b"TESTES", b"testicles by SuiAI", b"testes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/NPSUI_LOGO_a367f973c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTES>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTES>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

