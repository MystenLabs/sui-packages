module 0x372d05c55e927829dcca71c3c9032b4fe1f1133d2a43cf8724cd8cbfe935018e::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"trump.sui by SuiAI", b"A partnership between Donald Trump and Sui Network combines the world of high-profile real estate and business ventures with cutting-edge blockchain technology....In this futuristic partnership, Trump, known for his expansive empire in real estate, branding, and development, collaborates with Sui Network, a next-generation blockchain platform. The goal of this alliance is to merge traditional business with decentralized finance (DeFi), creating a new ecosystem that could redefine industries like real estate, investment, and even digital entertainment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1748573239031_641de48a71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

