module 0x3ef4fbdb9ad1a1693bc7ec5e86a613ce3a4dee3b1fedc6a933428fb971b5be18::verse {
    struct VERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERSE>(arg0, 6, b"Verse", b"Verse World", b"Not just a metaverse - an evolution. Build, explore & connect in hyper-realistic virtual worlds. The future is immersive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidch4l57vqqykhp6ydcqjlmadjpcsyn7dws6bbbpfrqnxjoqmeelu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VERSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VERSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

