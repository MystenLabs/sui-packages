module 0xfc60b4b3e60a625874ed0bba43a03306ff1f72eed2b6e1f2d2860dd6a544bce2::gensui {
    struct GENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENSUI>(arg0, 6, b"GENSUI", b"Gengar on Sui", x"47656e73756920697320746865206669727374206d656d6520506f6bc3a96d6f6e2067616d626c652067616d65206275696c74206f6e2053756920426c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiasi5kvg7unq35zod3ksdjlr6cneciy5jy3cbpxxpwqauqgefkxei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

