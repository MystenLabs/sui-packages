module 0xc56fdf10bcf1df6c4551c39988e1f453caac162f825967e5eff49fa8d5e9c111::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"HelloCoin by SuiAI", b"A fun and friendly meme coin that greets you with a 'Hello' in the world of cryptocurrencies. [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/6bLHgf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

