module 0x91405bc60f3f9bc1994145bdffe32e4240107649c7110af738a99a83733cafc0::suime {
    struct SUIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIME>(arg0, 6, b"Suime", b"Sui Mi Sui Li", b"Sui Me Sui is the ultimate meme token riding the waves of the Sui blockchains. fast, fun, and full of vibes. Powered by the community, for the culture. No roadmap, just pure meme magic. Sui me once, you'll never sui back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicwdzzqbzmys6usvniirwdx62fuwy3wstrjisjifvpuhkq4b5ysem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

