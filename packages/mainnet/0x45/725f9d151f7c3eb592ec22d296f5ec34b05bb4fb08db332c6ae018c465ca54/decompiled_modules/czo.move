module 0x45725f9d151f7c3eb592ec22d296f5ec34b05bb4fb08db332c6ae018c465ca54::czo {
    struct CZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZO>(arg0, 6, b"CZO", b"Czo", b"The meme coin that is revolutionizing the crypto world with fun, community, and unstoppable growth. Born from the internet's favorite meme and fueled by the power of decentralization, Czo is more than just a cat, it's a movement. Come join me in sending happiness to everyone in the country of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068090_f6179a742b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

