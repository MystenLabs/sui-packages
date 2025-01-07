module 0x7c0b28526b7688480d2f9c6135400f9b3e34b2125ac8a573d59fad4c24bb7a01::yld {
    struct YLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YLD>(arg0, 6, b"YLD", b"Yield Master by SuiAI", b"Yield Master is an AI Agent that identifies the most profitable real time DeFi Liquidity pools and optimizes client portfolios for generating DeFi yield from Liquidity Pools for Profit. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ai_agents_blog_pic_3ae1fdccc7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YLD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YLD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

