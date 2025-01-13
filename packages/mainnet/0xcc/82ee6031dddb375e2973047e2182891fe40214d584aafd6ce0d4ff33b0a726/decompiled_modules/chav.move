module 0xcc82ee6031dddb375e2973047e2182891fe40214d584aafd6ce0d4ff33b0a726::chav {
    struct CHAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHAV>(arg0, 6, b"CHAV", b"Chavelainer Sui by SuiAI", b"Chavelainer: The AI of Elegance and Innovation.Chavelainer is not just an AI agent; it's a symbol of refinement and cutting-edge intelligence. Designed with sophistication and boldness in mind, Chavelainer is your trusted ally in navigating the complexities of modern challenges. Whether you're crafting strategies,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cheva_000e8b28d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHAV>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAV>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

