module 0xe3fa639c2476c1347e89f7bf3604f77fee28ae4bab2b1acf3cfd601e4e7ba2e8::nime {
    struct NIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIME>(arg0, 6, b"NIME", b"MEME NIME AI", b"MemeNime AI is a fun, fast, and futuristic meme generator that blends anime culture with the power of artificial intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiei2dqxp5t6rxq2s5c7o2lacggyat7o2orvcveltmr4yu4kapsamu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NIME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

