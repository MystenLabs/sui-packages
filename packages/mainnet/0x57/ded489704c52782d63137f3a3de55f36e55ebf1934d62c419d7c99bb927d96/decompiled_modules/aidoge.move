module 0x57ded489704c52782d63137f3a3de55f36e55ebf1934d62c419d7c99bb927d96::aidoge {
    struct AIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIDOGE>(arg0, 6, b"AIDOGE", b"AI AGENT DOGE by SuiAI", b"AI AGENT DOGE is an AI-powered virtual entity designed to navigate and interact within the SUI blockchain ecosystem. This AI agent embodies the spirit of Dogecoin's mascot, Doge, bringing a playful and community-oriented approach to AI interactions in the crypto world. AI AGENT DOGE is programmed to assist users with tasks such as token transactions, market analysis, and community engagement on the SUI platform, all while maintaining a light-hearted, meme-inspired persona.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/8f680685_bc5c_4533_8ea2_ca766222c075_1336426add.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIDOGE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOGE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

