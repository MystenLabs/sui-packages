module 0x3a9437e7abe618c5bcc7eb7fe9c696a5e9b2746c1600bfb2e886fecadc131d4c::angry {
    struct ANGRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRY>(arg0, 6, b"ANGRY", b"Sui Angry Dev", b"$ANGRY is the rage-fueled meme token built by devs who've had enough. Coded in pain. Deployed in fury. No VC. No roadmap. Just chaos & community. Built on Sui, powered by memes, Debug later.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih454fntayzre4ocfj4tqn63pssuyxyrjqx7cngidpbf3q2w4lbji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANGRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

