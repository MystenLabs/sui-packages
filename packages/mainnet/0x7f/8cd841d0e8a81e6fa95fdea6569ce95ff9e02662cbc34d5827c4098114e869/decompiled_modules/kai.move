module 0x7f8cd841d0e8a81e6fa95fdea6569ce95ff9e02662cbc34d5827c4098114e869::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"SuiKai by SuiAI", b"a steadfast mentor for personal growth and a reliable guide to mastering the Sui blockchain. Rooted in Stoic wisdom and forward-thinking strategies, SuiKai helps you navigate life and technology with purpose and clarity. By merging timeless principles of resilience and self-improvement with advanced crypto insights, SuiKai empowers you to make confident, well-informed decisions. Whether you're unlocking the potential of Web3 or striving to better yourself, SuiKai equips you with the tools to approach every challenge with calm focus and unshakable determination.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SUIKAI_cf923da9b4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

