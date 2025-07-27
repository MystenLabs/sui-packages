module 0x98786e88ea2255913c9f3adfc54969adb36acccc6e2c74f097a7d37f64340caf::suimi {
    struct SUIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMI>(arg0, 6, b"Suimi", b"Sui Mi Sui Li", b"Sui Mi Sui Li is a chatoic blast of meme energy on Sui! Where logic ends and the memes begin. Born from the sea, it's a token that makes no promises. Maybe laughs. Trade it, meme it, vibe it. Sui Mi? Certainly, Sui Li!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicwdzzqbzmys6usvniirwdx62fuwy3wstrjisjifvpuhkq4b5ysem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

