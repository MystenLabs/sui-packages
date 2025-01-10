module 0xc1a35b6a9771e6eb69e3b36e921a3a373e6d33e6f863dab6949ed3c2d1228f73::neonet {
    struct NEONET has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEONET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NEONET>(arg0, 6, b"NEONET", b"NeoNet AI by SuiAI", b"NeoNet AI is a Matrix-inspired AI agent created to guide users through the complexities of the blockchain world, with a focus on the Sui ecosystem. It provides insights into market trends, token analysis, and potential risks, helping users make informed decisions in the evolving crypto landscape. Decode markets. Free minds. Be the One.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Untitled_design_36_85652fc1fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEONET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEONET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

