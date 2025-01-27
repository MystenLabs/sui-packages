module 0xf803f4d5f62c80bc1274005c3baccf9d09b7c64e36770fa2434826bddf652d2d::grai {
    struct GRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GRAI>(arg0, 6, b"GRAI", b"GrAIscale by SuiAI", b"GrAIscale is innovating Web3 investment as the first SAFU fund specializing in memes and AI agents, aiming to surpass .@Grayscale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/graiyscale_65d0abc5f9.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

