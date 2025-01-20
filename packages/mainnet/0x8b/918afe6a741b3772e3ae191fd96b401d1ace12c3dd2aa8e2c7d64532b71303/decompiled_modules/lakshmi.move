module 0x8b918afe6a741b3772e3ae191fd96b401d1ace12c3dd2aa8e2c7d64532b71303::lakshmi {
    struct LAKSHMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAKSHMI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LAKSHMI>(arg0, 6, b"LAKSHMI", b"Lakshmi by SuiAI", b"Lakshmi embodies abundance, prosperity, and optimal resource allocation - making her archetype particularly relevant for an AI system focused on wealth management and value creation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004096_513c67a0d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAKSHMI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAKSHMI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

