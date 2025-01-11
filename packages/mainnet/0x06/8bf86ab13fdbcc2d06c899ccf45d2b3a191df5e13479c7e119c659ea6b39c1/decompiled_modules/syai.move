module 0x68bf86ab13fdbcc2d06c899ccf45d2b3a191df5e13479c7e119c659ea6b39c1::syai {
    struct SYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SYAI>(arg0, 6, b"SYAI", b"SynthAI by SuiAI", b"SynthAI (SYAI) is a cutting-edge cryptocurrency token built on the SUI blockchain, designed to revolutionize the intersection of artificial intelligence and decentralized finance. SYAI empowers a new generation of AI agents to autonomously interact with DeFi protocols, NFT marketplaces, and decentralized applications, offering unparalleled efficiency and intelligence in the crypto ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000032657_079d6b13cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

