module 0x8a37bd84584357543a742cfcdad72f9c986ac74079bce7ab1a4169c2efdb9aaf::eltler {
    struct ELTLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELTLER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELTLER>(arg0, 6, b"ELTLER", b"Elon Hitler by SuiAI", b"Elon hitler meme in sol, right now in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1104_9b58512a25.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELTLER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELTLER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

