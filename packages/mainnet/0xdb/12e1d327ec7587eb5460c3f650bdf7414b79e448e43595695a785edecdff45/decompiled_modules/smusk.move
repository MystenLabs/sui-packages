module 0xdb12e1d327ec7587eb5460c3f650bdf7414b79e448e43595695a785edecdff45::smusk {
    struct SMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SMUSK>(arg0, 6, b"SMUSK", b"SUI AI President Musk by SuiAI", b"Sui AI President Musk (SMUSK) is an AI-powered agent that embodies the persona of Elon Musk, serving as the president of the crypto and Web3 community. Designed to lead and inspire, SMUSK drives innovation and development within the decentralized world, offering strategic guidance and fostering growth in blockchain technologies and decentralized finance. Through its unique AI-driven approach, SMUSK aims to unite and empower the community, guiding them towards a decentralized future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/elon_musk_logo_2ad75d4776.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMUSK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUSK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

