module 0x6427374cd0c2a81dd65d0530377f302d88eb67e395a7da493b47e8daeb42482d::laxmi {
    struct LAXMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAXMI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LAXMI>(arg0, 6, b"LAXMI", b"Laxmi by SuiAI", b"Lakshmi embodies abundance, prosperity, and optimal resource allocation - making her archetype particularly relevant for an AI system focused on wealth management and value creation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004096_9d611330b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAXMI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAXMI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

