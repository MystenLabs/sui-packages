module 0x8fde674216e25e1aff480ed10cc2888f490f92bf1abdc7a8ae672a0d1c319adf::wworm {
    struct WWORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWORM>(arg0, 6, b"Wworm", b"Water worm", b"Deep beneath the liquid layers of the sui blockchain swims a legendary creature. Meet Wworm, the meme that wiggles through dips, rides the waves, and splashes FOMO on every chart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidxczkmzqpj753ghkrpz57vjzxzb3nsgiu6nnlhrckq5xflcustly")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WWORM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

