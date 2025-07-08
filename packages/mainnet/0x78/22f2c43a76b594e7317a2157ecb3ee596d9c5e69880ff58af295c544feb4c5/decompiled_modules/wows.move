module 0x7822f2c43a76b594e7317a2157ecb3ee596d9c5e69880ff58af295c544feb4c5::wows {
    struct WOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWS>(arg0, 6, b"WOWS", b"Suiwow", b"$WOWS next the biggest meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidncvvkwzl6mppgetust7ma2ad73kt4agplirk5mwruyex67auhjq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOWS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

