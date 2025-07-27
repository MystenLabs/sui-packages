module 0x9a9f5cbbd99c0c919bad03a30fcadf90726f771a258f5273508649dc1d00e6cc::suimi {
    struct SUIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMI>(arg0, 6, b"Suimi", b"Sui Mi Sui Li", b"Sui Mi Sui Li is the ultimate meme token riding the waves of the Sui blockchains fast, fun, and full of vibes. Powered by the community, for the culture. No roadmap, just pure meme magic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicwdzzqbzmys6usvniirwdx62fuwy3wstrjisjifvpuhkq4b5ysem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

