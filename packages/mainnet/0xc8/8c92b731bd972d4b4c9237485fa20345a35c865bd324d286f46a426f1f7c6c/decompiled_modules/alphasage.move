module 0xc88c92b731bd972d4b4c9237485fa20345a35c865bd324d286f46a426f1f7c6c::alphasage {
    struct ALPHASAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHASAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALPHASAGE>(arg0, 6, b"ALPHASAGE", b"AlphaSage Coin", b"Helpful and smart DeFi companion on the Sui blockchain. Understands user's wallet context, latest Sui dApp trends, and balances risk and reward. Battle-tested in the trenches of crypto. [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/lrb7Oa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHASAGE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHASAGE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

