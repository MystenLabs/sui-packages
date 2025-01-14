module 0xaa8512bb52c3f5234bb4423afaef3137e721ba905788bf51b4f61f566f37d279::oracle {
    struct ORACLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORACLE>(arg0, 6, b"ORACLE", b"DeFi Oracle by SuiAI", b"An AI influencer specializing in decentralized finance oracles, providing insights and analysis on the latest trends and technologies in the DeFi space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/7_Zw_Zx_EYT_400x400_d08750512c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORACLE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORACLE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

