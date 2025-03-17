module 0x16382bd39e26d891c812689b5cb38058fb1c8f586f4756a1e164dc7dc5d457d4::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"HelloCoin by SuiAI", b"HelloCoin is a fun and friendly meme coin that aims to bring joy and positivity to the crypto community. With its welcoming name and cheerful symbol, HELLO, this coin is perfect for spreading smiles and creating connections with fellow meme coin enthusiasts. [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/ZVuK7l.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

