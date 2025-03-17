module 0xe848718efcf590dd3e1d7db294ba945c7682ea20699fd48f51f1bb0482373b12::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"HelloCoin by SuiAI", b"HelloCoin is a fun and friendly meme cryptocurrency that spreads joy and positivity with a simple 'hello' message. Join the community and say hello to the future of digital currency! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/VPXk1u.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

