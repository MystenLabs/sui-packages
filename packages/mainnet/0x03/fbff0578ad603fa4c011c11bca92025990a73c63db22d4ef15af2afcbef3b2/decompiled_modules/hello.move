module 0x3fbff0578ad603fa4c011c11bca92025990a73c63db22d4ef15af2afcbef3b2::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"Hello Coin by SuiAI", b"Hello Coin is a fun and friendly meme coin that brings a cheerful greeting to the world of cryptocurrency. Say hello to the future with Hello Coin! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/VnUSAi.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

