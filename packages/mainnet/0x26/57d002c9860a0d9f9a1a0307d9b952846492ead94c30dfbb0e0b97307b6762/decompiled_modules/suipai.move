module 0x2657d002c9860a0d9f9a1a0307d9b952846492ead94c30dfbb0e0b97307b6762::suipai {
    struct SUIPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPAI>(arg0, 6, b"SuiPAI", b"Sui Price AI", b"In the fast-evolving Sui ecosystem, Price AI Stands as a smart, decentralized pricing oracle and prediction engine. Design to bring real-time, transparent and tamper-resistant price feeds, Price AI uses advanced machine learning models and on-chain data to deliver accurate valuations for assets, goods, or services traded within the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiba4oujlbth5itwtjye36roaktpdsevpa2okyhzrz4gutkrd7rwja")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIPAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

