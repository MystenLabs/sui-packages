module 0x385e54af68b0e3b41358c907dbee982f7a9272a6e20f25aadd19101d9f30a38a::cms {
    struct CMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMS>(arg0, 6, b"CMS", b"CookieMonster On Sui", b"I dont follow trends, I create them. I represent the degenerates and the dreamers, Im SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih6577thke6nejppn6oefpsgazmz4qi3kw5qc3o4xf3vag3uzut7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CMS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

