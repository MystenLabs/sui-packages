module 0xc39b3e98797277d19c938a8f8bdc84fe010625005ccdd0105e4f13f6dfd44080::bac {
    struct BAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BAC>(arg0, 6, b"BAC", b"BAC by SuiAI", b"BAC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/your_paragraph_text_18162522681_16509370b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

