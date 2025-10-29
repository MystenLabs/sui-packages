module 0x1e2477bc55a494c61f8b403be236b15dbcadbb813f2b4384816a614c70e686ab::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 6, b"LOL", b"Lol Sui", b"The most famous meme in the world, the lol face is now live on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiastu6oj3zrb7gb6sr6bgfmrsjtbkuzpsk6jnzqlyipbx7gyinb2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

